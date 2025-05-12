class OmniauthController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: [ :github ]
  def github
    Rails.logger.info("Omniauth github: #{request.env['omniauth.auth']}")

    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Github"
      sign_in(resource_name, @user)
      session[:user_id] = @user.id
      session[:provider] = auth.provider
      session[:uid] = auth.uid
      redirect_to profile_user_path(@user), event: :authentication
    else
      redirect_to root_url, alert: "Unable to sign in via Github."
    end
  end

  def failure
    Rails.logger.error("Omniauth failure: #{request.env['omniauth.error']}")
    Rails.logger.error("Omniauth failure: #{request.env['omniauth.error.strategy']}")
    redirect_to root_url, alert: "Failed to sign in via Github! 😰"
  end
end
