class Preference < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  belongs_to :event
  #times should look like:
  #[{start: DATETIME, end: DATETIME},{start: ...},...]
  serialize  :times
  attr_accessible :user, :times
  def optimize
    puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~"
    puts "RUNNING THE EVENT OPTIMIZER, YO"
    puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~"
  end
end
