defmodule Ctrlv.Pastes.PUID do
  # To generate up to 1 million puids with 1 in a trillion chance of repeat:
  use Puid, total: 1.0e6, risk: 1.0e12
end
