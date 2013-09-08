class Event < ActiveRecord::Base
  belongs_to :activity
  serialize  :users
  attr_accessible :activity, :users, :start_time, :end_time
  # attr_accessible :title, :body
end
