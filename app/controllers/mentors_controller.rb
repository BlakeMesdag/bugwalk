class MentorsController < ApplicationController
  before_filter :load_mentor, :except => [:index]

  respond_to :html, :json
  def index
    @user = User.find(session[:user_id])
    @mentors = User.all_mentors - [@user]

    respond_with @mentors
  end

  def new
    respond_with @mentor
  end

  def create
    @mentor.update_attributes(params[:user])

    redirect_to :action => 'show'
  end

  def edit
    respond_with @mentor
  end

  def update
    @mentor.update_attributes(params[:user])

    redirect_to :action => 'index'
  end

  def destroy
    @mentor.update_attributes(:is_mentor => false)

    redirect_to :action => 'index'
  end

  def load_mentor
    @mentor = User.find(session[:user_id])
  end

end
