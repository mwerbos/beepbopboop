class Event < ActiveRecord::Base
  belongs_to :activity
  # attr_accessible :title, :body
end
