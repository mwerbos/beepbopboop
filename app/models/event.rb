class Event < ActiveRecord::Base
  belongs_to :activity
  serialize  :users
  # attr_accessible :title, :body
end
