class Preference < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  belongs_to :event
  #times should look like:
  #[{start: DATETIME, end: DATETIME},{start: ...},...]
  serialize  :times
  # attr_accessible :title, :body
end
