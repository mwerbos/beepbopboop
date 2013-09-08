class Preference < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  belongs_to :event
  #times should look like:
  #[{start: DATETIME, end: DATETIME},{start: ...},...]
  serialize  :times
  attr_accessible :user, :times

  def earliestTime
    times = []
    self.times.each do |time|
      times.push(time[:start])
    end
    return times.min
  end
 
end
