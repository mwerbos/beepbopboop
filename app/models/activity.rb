class Activity < ActiveRecord::Base
  require File.join(Rails.root,"lib/choose_optimal.rb")
  has_many :preferences
  attr_accessible :name
  def generate_availability
    prefs=self.preferences
    data={}
    prefs.each do |pref|
      data.merge!({pref.user => pref.times}){|k,v1,v2| v1+v2}
    end
    out = {}
    out["users"] =data.keys.map do |user|
        {id: user.id,username:user.username,times: data[user]}
      end
    out["times"] = choose_optimal(self)
      out.to_json
  end

end
