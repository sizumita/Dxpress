defmodule Dxpress.Structs.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :avatar, :string
    field :bot, :boolean, default: false
    field :discriminator, :string
    field :email, :string
    field :flags, :integer
    field :locale, :string
    field :mfa_enabled, :boolean, default: false
    field :premium_type, :integer
    field :public_flags, :integer
    field :system, :boolean, default: false
    field :username, :string
    field :verified, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :discriminator, :avatar, :bot, :system, :mfa_enabled, :locale, :verified, :email, :flags, :premium_type, :public_flags])
    |> validate_required([:username, :discriminator, :avatar])
  end
end
