class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: [ :github, :githubdr ]

  def all
    Rails.logger.info("Omniauth github: #{request.env['omniauth.auth']}")

    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)
    if @user.persisted?
      sign_in(@user, event: :authentication)
      redirect_to profile_user_path(current_user), notice: "Successfully linked your account!"
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to root_url, alert: "We could not link that account. Please try again."
    end
  end

  def passthru
    render status: 404, plain: "!!!!!! Not found. Authentication passthru in OmniauthCallbacksController. !!!!!!"
  end

  def failure
    Rails.logger.error("Omniauth failure: #{request.env['omniauth.error']}")
    Rails.logger.error("Omniauth failure: #{request.env['omniauth.error.strategy']}")
    redirect_to root_url, alert: "Failed to sign in via Github! 😰"
  end

  [ :github, :githubdr ].each do |k|
    alias_method k, :all
  end
end
