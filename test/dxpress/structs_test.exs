defmodule Dxpress.StructsTest do
  use Dxpress.DataCase

  alias Dxpress.Structs

  describe "users" do
    alias Dxpress.Structs.User

    @valid_attrs %{avatar: "some avatar", bot: true, discriminator: "some discriminator", email: "some email", flags: 42, locale: "some locale", mfa_enabled: true, premium_type: 42, public_flags: 42, system: true, username: "some username", verified: true}
    @update_attrs %{avatar: "some updated avatar", bot: false, discriminator: "some updated discriminator", email: "some updated email", flags: 43, locale: "some updated locale", mfa_enabled: false, premium_type: 43, public_flags: 43, system: false, username: "some updated username", verified: false}
    @invalid_attrs %{avatar: nil, bot: nil, discriminator: nil, email: nil, flags: nil, locale: nil, mfa_enabled: nil, premium_type: nil, public_flags: nil, system: nil, username: nil, verified: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Structs.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Structs.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Structs.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Structs.create_user(@valid_attrs)
      assert user.avatar == "some avatar"
      assert user.bot == true
      assert user.discriminator == "some discriminator"
      assert user.email == "some email"
      assert user.flags == 42
      assert user.locale == "some locale"
      assert user.mfa_enabled == true
      assert user.premium_type == 42
      assert user.public_flags == 42
      assert user.system == true
      assert user.username == "some username"
      assert user.verified == true
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Structs.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Structs.update_user(user, @update_attrs)
      assert user.avatar == "some updated avatar"
      assert user.bot == false
      assert user.discriminator == "some updated discriminator"
      assert user.email == "some updated email"
      assert user.flags == 43
      assert user.locale == "some updated locale"
      assert user.mfa_enabled == false
      assert user.premium_type == 43
      assert user.public_flags == 43
      assert user.system == false
      assert user.username == "some updated username"
      assert user.verified == false
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Structs.update_user(user, @invalid_attrs)
      assert user == Structs.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Structs.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Structs.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Structs.change_user(user)
    end
  end
end
