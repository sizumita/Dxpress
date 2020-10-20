defmodule Dxpress.Repo do
  use Ecto.Repo,
    otp_app: :dxpress,
    adapter: Ecto.Adapters.MyXQL
end
