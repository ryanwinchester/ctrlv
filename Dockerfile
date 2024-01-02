# Find eligible builder and runner images on Docker Hub. We use Ubuntu/Debian instead of
# Alpine to avoid DNS resolution issues in production.
#
# https://hub.docker.com/r/hexpm/elixir/tags?page=1&name=ubuntu
# https://hub.docker.com/_/ubuntu?tab=tags
#
#
# This file is based on these images:
#
#   - https://hub.docker.com/r/hexpm/elixir/tags - for the build image
#   - https://hub.docker.com/_/debian?tab=tags&page=1&name=bullseye-20210902-slim - for the release image
#   - https://pkgs.org/ - resource for finding needed packages
#   - Ex: hexpm/elixir:1.13.3-erlang-24.2-debian-bullseye-20210902-slim
#
ARG ELIXIR_VERSION=1.16.0
ARG OTP_VERSION=26.2.1
ARG DEBIAN_VERSION=buster-20231009-slim

ARG RUST_IMAGE="rust:slim-buster"
ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
ARG RUNNER_IMAGE="debian:${DEBIAN_VERSION}"

FROM ${RUST_IMAGE} as rust

FROM ${BUILDER_IMAGE} as builder

# install build dependencies
RUN apt-get update -y && apt-get install -y build-essential git
    # && apt-get clean && rm -f /var/lib/apt/lists/*_*

# rust shenanigans
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH
COPY --from=rust /usr/local/cargo /usr/local/cargo
COPY --from=rust /usr/local/rustup /usr/local/rustup

# rustler/python3 dependencies
RUN apt-get update -y && apt-get install -y expat libxml2-dev pkg-config \
    libfontconfig1-dev libasound2-dev libssl-dev cmake libfreetype6-dev \
    libexpat1-dev libxcb-composite0-dev libharfbuzz-dev
    # && apt-get clean && rm -f /var/lib/apt/lists/*_*

# install python3 for rustler
RUN apt-get update -y && apt-get install -y libssl-dev libffi-dev python3-dev \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV="prod"

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mkdir config

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
COPY config/config.exs config/${MIX_ENV}.exs config/
RUN mix deps.compile

COPY priv priv

# Compile the release
COPY lib lib
# compile assets
COPY assets assets
RUN mix assets.deploy
RUN mix compile

# Changes to config/runtime.exs don't require recompiling the code
COPY config/runtime.exs config/

COPY rel rel
RUN mix release

# start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM ${RUNNER_IMAGE}

RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncurses5 locales
  # && apt-get clean && rm -f /var/lib/apt/lists/*_*

# rustler stuff needed in runner image
RUN apt-get update -y && apt-get install -y expat libxml2-dev pkg-config \
    libfontconfig1-dev libasound2-dev libssl-dev cmake libfreetype6-dev \
    libexpat1-dev libxcb-composite0-dev libharfbuzz-dev fonts-firacode \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR "/app"
RUN chown nobody /app

# Only copy the final release from the build stage
COPY --from=builder --chown=nobody:root /app/_build/prod/rel/ctrlv ./

USER nobody

CMD ["/app/bin/server"]
