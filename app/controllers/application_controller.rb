class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  def authenticate
    redirect_to '/login' unless session[:active]
  end
end
