class EventsController < ApplicationController
  before_filter :load_event, :except => [:index, :create, :new]

  respond_to :html, :json

  def index
    d = Date.today
    start_date = d.at_beginning_of_week(:sunday).strftime
    end_date = d.at_end_of_week(:sunday).strftime
    @this_weeks_events = Event.where("starts_at > ? AND starts_at < ?", start_date, end_date).limit(1)
    @this_weeks_event = @this_weeks_events.first

    relation = Event.order("starts_at DESC").where("starts_at > ?", Time.now.utc)
    relation = relation.limit(10).offset(10 * (params[:page].to_i - 1)) if params[:page] && params[:page].to_i > 0
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
    @event = Event.new(params[:event])
    @event.ends_at = @event.starts_at + 1.hour
    @event.save

    respond_with @event
  end

  def edit
    respond_with @event
  end

  def update
    @event.update_attributes(params[:event])
    
    redirect_to :action => 'show'
  end

  def destroy
    @event.destroy
    
    redirect_to :action => 'index'
  end

  private

  def load_event
    @event = Event.find(params[:id])
  end
end
