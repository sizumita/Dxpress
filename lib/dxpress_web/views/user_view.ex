defmodule DxpressWeb.UserView do
  use DxpressWeb, :view
  alias DxpressWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      discriminator: user.discriminator,
      avatar: user.avatar,
      bot: user.bot,
      system: user.system,
      mfa_enabled: user.mfa_enabled,
      locale: user.locale,
      verified: user.verified,
      email: user.email,
      flags: user.flags,
      premium_type: user.premium_type,
      public_flags: user.public_flags}
  end
end
