class ActivitiesController < ApplicationController
  before_filter :setup_new_user_and_session, :except => ['search']
  def show
    @activity = Activity.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def browse
    # TODO: make per_page settable?
    @activities = Activity.reorder("id DESC").paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
    end
  end

  def search
    @term = params[:term]
    # TODO make it actually use the search term
    activities = Activity.all
    activities_json = activities.inject([]) do |result, activity|
      result << {label: activity.name, value: activity.name}
    end
    render json: activities_json
  end

end
