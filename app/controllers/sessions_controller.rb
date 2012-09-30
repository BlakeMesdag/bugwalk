class SessionsController < ApplicationController
  skip_before_filter :authenticate

  def new
    redirect_to '/auth/google'
  end

  def create
    if auth = request.env['omniauth.auth']
      session[:active] = true
      redirect_to '/'
    end
  end
end
