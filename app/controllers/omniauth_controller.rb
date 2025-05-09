class OmniauthController < Devise::OmniauthCallbacksController
  def github
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)
    if @user.present?
      .slug = auth.info.nickname
      .name = auth.info.name
      .image_remote_url = auth.info.image
      .title = auth.extra.raw_info.bio
      .location = auth.extra.raw_info.location
      .homepage_uri = auth.extra.raw_info.blog if auth.extra.raw_info.blog.present?
      .github_uri = "https://github.com/#{auth.info.nickname}"
      .save if @user.changed?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Github"
      sign_in(resource_name, @user)
      redirect_to root_url, event: :authentication
    else
      redirect_to root_url, alert: "Unable to sign in via Github"
    end
  end

end
