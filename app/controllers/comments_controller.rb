class CommentsController < ApplicationController
  before_filter :load_comment, :except => :create

  def create
    @comment = @user.comments.create(params[:comment])

    require 'debugger'; debugger

    redirect_to :controller => 'events', :action => 'show', :id => @comment.reload.event_id
  end

  def update
    @comment.update_attributes(params[:comment])

    redirect_to :controller => 'events', :action => 'show', :id => @comment.event_id
  end

  def destroy
    @comment.destroy

    redirect_to :controller => 'events', :action => 'show', :id => @comment.event_id
  end

  private

  def load_comment
    @comment = @user.comments.find(params[:id])
  end
end
