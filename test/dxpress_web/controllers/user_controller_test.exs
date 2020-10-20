defmodule DxpressWeb.UserControllerTest do
  use DxpressWeb.ConnCase

  alias Dxpress.Structs
  alias Dxpress.Structs.User

  @create_attrs %{
    avatar: "some avatar",
    bot: true,
    discriminator: "some discriminator",
    email: "some email",
    flags: 42,
    locale: "some locale",
    mfa_enabled: true,
    premium_type: 42,
    public_flags: 42,
    system: true,
    username: "some username",
    verified: true
  }
  @update_attrs %{
    avatar: "some updated avatar",
    bot: false,
    discriminator: "some updated discriminator",
    email: "some updated email",
    flags: 43,
    locale: "some updated locale",
    mfa_enabled: false,
    premium_type: 43,
    public_flags: 43,
    system: false,
    username: "some updated username",
    verified: false
  }
  @invalid_attrs %{avatar: nil, bot: nil, discriminator: nil, email: nil, flags: nil, locale: nil, mfa_enabled: nil, premium_type: nil, public_flags: nil, system: nil, username: nil, verified: nil}

  def fixture(:user) do
    {:ok, user} = Structs.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "avatar" => "some avatar",
               "bot" => true,
               "discriminator" => "some discriminator",
               "email" => "some email",
               "flags" => 42,
               "locale" => "some locale",
               "mfa_enabled" => true,
               "premium_type" => 42,
               "public_flags" => 42,
               "system" => true,
               "username" => "some username",
               "verified" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "avatar" => "some updated avatar",
               "bot" => false,
               "discriminator" => "some updated discriminator",
               "email" => "some updated email",
               "flags" => 43,
               "locale" => "some updated locale",
               "mfa_enabled" => false,
               "premium_type" => 43,
               "public_flags" => 43,
               "system" => false,
               "username" => "some updated username",
               "verified" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
