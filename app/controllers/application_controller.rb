class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  def authenticate
    session[:redirect_to] = request.path
    redirect_to '/login' unless session[:active]
  end
end
