class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :profile ]
  before_action :set_current_user_identity, only: [ :profile ]

  def profile
  end

  private

  def set_user
    @user = current_user
  end

  def set_current_user_identity
    @current_user_identity ||= current_user.identities.find_by(provider: session[:provider], uid: session[:uid]) || nil
  end
end
