# Ctrlv

Code paste-bin and editor.

![ctrlv-02](https://user-images.githubusercontent.com/2897340/160538360-cab5957d-263d-4348-97af-bc9708087ffb.gif)

## Features

- [x] Simple and clean UI
- [x] Editor with syntax highlighting
- [x] Saving with expiration
- [x] Forking
- [ ] Editor plugins (in progress, see below)
- [ ] Code screenshots (in progress)
- [ ] CLI tool (planned)
- [x] Works on mobile (see image below)
- [ ] User accounts (planned)
  - [ ] Non-expiring
  - [ ] Delete

#### Mobile view

<div align="center">
  <img alt="ctrlv mobile" height="480" src="/priv/static/images/mobile.png" />
</div>

## Editor plugins

- [VS Code](https://marketplace.visualstudio.com/items?itemName=ryanwinchester.ctrlv)
- Neovim (coming soon)

## Development and Self-hosting

### Local dev

 1. If you need to override config (like what is in `config/dev.exs`), do so in a `config/dev.secret.exs` file. (same for `test`)
 2. To get deps and setup the DB run `mix setup`
 3. To start with an IEx console run `iex -S mix phx.server`

### Deploy

#### Deploying on fly.io

Change the `"app"` name in `fly.toml` and run `fly launch`.

#### Deploying elsewhere

Use the `Dockerfile` to build an image and deploy it.

## Roadmap

#### v1.0

- [x] Save
- [x] Fork
- [x] New
- [x] ~~CodeMirror 6 languages~~
- [x] ~~CodeMirror Legacy languages~~
- [x] Elixir language
- [x] Limit content length
- [ ] Cache
- [ ] Rate-limiting `save`
- [x] Delete expired pastes
- [ ] Testing and Static Analysis
  * [ ] ExUnit
  * [ ] Credo
  * [ ] Dialyzer
- [ ] CI/CD (Github actions)
- [x] Deploy
- [ ] meta/og tags for better links
- [x] Mobile menus
- [ ] Overlayed alerts/errors

#### v2.0

- [x] Monaco editor
- [x] Improve/fix "flash" between `show` and `fork`
- [ ] Versions
- [ ] Advanced settings (`tabSize`, etc)
- [ ] Help menu
- [ ] Real-time(ish) code updates

#### v3.0 (potential ideas/wishlist for now)

- [ ] User accounts for non-expiring, and deletable pastes

## About

### Why did I make this?

To be honest, I just don't like most pastebin things for code, and the ones I do
like don't support Elixir syntax highlighting. That's the reason I started it.

I just want a non-cluttered UI and support for the languages I use.

### Main technologies:

- [Elixir](https://elixir-lang.org)
- [Phoenix Framework](https://www.phoenixframework.org/)
- [Monaco Editor](https://github.com/microsoft/monaco-editor)
- [PostgreSQL](https://www.postgresql.org/)
- [Tailwind CSS](https://tailwindcss.com/)
- [TypeScript](https://www.typescriptlang.org/)
- See [mix.exs](https://github.com/ryanwinchester/ctrlv/blob/main/mix.exs) deps and [package.json](https://github.com/ryanwinchester/ctrlv/blob/main/assets/package.json) for more.


## Copyright and License

Copyright 2022 Ryan Winchester

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
