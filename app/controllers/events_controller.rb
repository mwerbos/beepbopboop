class EventsController < ApplicationController
  before_filter :setup_new_user_and_session
  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  def browse
    # TODO: make per_page settable?
    @events = Event.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
    end
  end

end
