class SessionsController < ApplicationController
  skip_before_filter :authenticate, :verify_authenticity_token

  def new
    redirect_to '/auth/google'
  end

  def create
    redirect_to = session[:redirect_to]
    reset_session

    if auth = request.env['omniauth.auth']
      session[:active] = true

      user = User.where(:email => auth['info']['email']).first

      unless user
        user = User.create!(:name => auth['info']['name'], :email => auth['info']['email'], :is_mentor => 'f')
      end

      session[:user_id] = user.id

      redirect_to redirect_to.nil? ? "/" : redirect_to
    end
  end
end
