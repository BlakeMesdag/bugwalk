class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate, :load_user

  def authenticate
    session[:redirect_to] = request.path
    redirect_to '/login' unless session[:active]
  end

  def load_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end
end
