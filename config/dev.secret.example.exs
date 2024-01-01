import Config

config :ctrlv, Ctrlv.Integrations.AWS.Client,
  access_key_id: "",
  secret_access_key: "",
  region: ""

config :ctrlv, Ctrlv.Integrations.AWS.S3,
  bucket: ""
