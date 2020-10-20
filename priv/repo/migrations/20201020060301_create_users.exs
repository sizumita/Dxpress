defmodule Dxpress.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :discriminator, :string
      add :avatar, :string
      add :bot, :boolean, default: false, null: false
      add :system, :boolean, default: false, null: false
      add :mfa_enabled, :boolean, default: false, null: false
      add :locale, :string
      add :verified, :boolean, default: false, null: false
      add :email, :string
      add :flags, :integer
      add :premium_type, :integer
      add :public_flags, :integer

      timestamps()
    end

  end
end
