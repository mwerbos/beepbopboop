class Preference < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  belongs_to :event
  # attr_accessible :title, :body
end
