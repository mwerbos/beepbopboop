class ActivitiesController < ApplicationController
  def browse
    # TODO: make per_page settable?
    @activities = Activity.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
    end
  end

end
