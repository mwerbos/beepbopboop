class PreferencesController < ApplicationController
  def create
    raw_times=JSON.parse(params[:preference][:ranges])
    times=raw_times.map do |h|
      {start: Time.strptime(h["start"],"%m/%d/%Y %I:%M %P"),
        end: Time.strptime(h["end"],"%m/%d/%Y %I:%M %P")}
    end
    @preference = Preference.new(user: current_user,times: times)
    @activity = Activity.where(:name => params[:preference][:activity]).first
    if(!@activity)
      @activity = Activity.new
      @activity.name = params[:preference][:activity]
      # TODO make this part of a transaction
      @activity.save
    end
    @preference.activity = @activity
    puts "*****************************"
    puts @preference.inspect
    puts "*****************************"
      respond_to do |format|
      if (@activity and @preference.save)
        @preference.delay.optimize
        format.html { redirect_to "/", :notice => 'Preference was successfully created.' }
        format.json { render :json => @preference, :status => :created, :location => @preference }
      else
        format.html { redirect_to "/", :notice => 'Could not create preference.' }
        format.json { render :json => @preference.errors, :status => :unprocessable_entity }
      end
    end
  end
end
