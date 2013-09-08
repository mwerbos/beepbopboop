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
    out["times"] = self.choose_optimal
      out.to_json
  end

  def earliestTime
    prefs=self.preferences
    puts prefs
    times = []
    prefs.each do |pref|
      pref.times.each do |time|
        times.push(time[:start])
      end
    end
    puts times.inspect
    return times.min
  end

  def choose_optimal
    #prefs = Preference.where(activity: self)
    
    prefs = Preference.where(activity_id: self)
    
    while true
      
      allRanges = prefs.map { |pref| pref.times }
      
      relevantTimes = []
      
      # puts "\nNumber of ranges:" + String(allRanges.size)
        
      allRanges.flatten.each {
        |range|
        relevantTimes.push(range[:start]).push(range[:end])
      }
      
      relevantTimes = relevantTimes.sort
      # puts relevantTimes
      
      timeRanges = {}
      
      if relevantTimes.size > 0
        (relevantTimes.size-1).times {
          |i|
          if relevantTimes[i] != relevantTimes[i+1]
            timeRanges[{start:relevantTimes[i], end:relevantTimes[i+1]}] = 0
          end
        }
        
        timeRanges.keys.each {
          |timeRange|
          middleTime = range_middle(timeRange)
          utility = is_within(middleTime,range_span(timeRange), prefs,self)
          timeRanges[timeRange] = utility
        }
        
        # puts timeRanges
        
        bestValue = timeRanges.values.max
        
        if bestValue == 0
          break
        end
        
        bestRange = timeRanges.key(bestValue)
        
        puts "BEST RANGE: " + String(bestRange)
        
        ids = get_within(range_middle(bestRange), prefs)
            
        ids.each {
          |id|
          p = prefs.select{|pref| pref.id == id}[0]
          p.repeats -= 1
        }
        
        prefs.each {
          |pref|
          
          if pref.repeats <= 0
            pref.interest = 0
          end
          
          puts pref.id
          puts "\t" + String(pref.repeats)
          puts "\t" + String(pref.interest)
        }
      else
        break
      end
    end
    return nil
  end

  def check_and_create_event
    # Find the preference with the closest time range.
    prefs = Preference.where(activity_id: self)
    min_pref = prefs.first
    min_time = prefs.first.times.first[:start]
    prefs.each do |pref|
      pref.times.each do |time|
        if(time[:start] < min_time)
          min_time = time[:start]
          min_pref = pref
        end
      end
    end
    # Check if an optimal schedule includes it. 
    # If it does, schedule the event!
  end

end
