class EventsController < ApplicationController
  before_filter :load_event, :except => [:index, :create, :new]

  respond_to :html, :json

  def index
    d = Date.today
    start_date = d.at_beginning_of_week(:sunday).strftime
    end_date = d.at_end_of_week(:sunday).strftime
    @this_weeks_events = Event.where("starts_at > ? AND starts_at < ?", start_date, end_date)

    relation = Event.order("starts_at DESC").limit(10)
    relation = relation.offset(10 * (params[:page].to_i - 1)) if params[:page] && params[:page].to_i > 0
    @events = relation.all - @this_weeks_events

    @event_count = Event.count
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
