class EventsController < ApplicationController
  before_filter :load_event, :except => [:index, :create, :new]

  respond_to :html, :json

  def index
    @events = Event.order("starts_at DESC").all
  end

  def show
    respond_with @event
  end

  def new
    @event = Event.new

    respond_with @event
  end

  def create
    @bug = Bug.create(params[:bug])

    respond_with @bug
  end

  def edit
    respond_with @event
  end

  def update
    @event.update_attributes(params[:event])
    
    respond_with @event
  end

  def destroy
    @event.destroy
    
    respond_with @event
  end

  private

  def load_event
    @event = Event.find(params[:id])
  end
end
