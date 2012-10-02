class MenteesController < ApplicationController
  before_filter :load_mentee

  def create
    if Mentorship.where(:mentor_id => params[:mentor_id], :mentee_id => @mentee.id).none?
      Mentorship.create(:mentor_id => params[:mentor_id], :mentee_id => @mentee.id)
    end

    redirect_to :controller => "mentors", :action => "index"
  end

  def destroy
    Mentorship.where(:mentor_id => params[:mentor_id], :mentee_id => @mentee.id).destroy_all

    redirect_to :controller => "mentors", :action => "index"
  end

  private
  def load_mentee
    @mentee = User.find(session[:user_id])
  end
end
