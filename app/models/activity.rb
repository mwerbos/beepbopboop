class Activity < ActiveRecord::Base
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
	out["times"] = []
    out.to_json
  end

end
