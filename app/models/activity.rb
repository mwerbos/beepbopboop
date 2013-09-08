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
  
  
  def average_size_satisfaction(min,ideal,max,n)
  width=[max-ideal,ideal-min].max.to_f
  if n<=ideal
    if n>=min
      return 1-0.3*(ideal-n)/width
    else
      return 0
    end
  else
    if n<2*ideal
      last=n
      rest=0
    else n>2*ideal
      last=n%ideal+ideal
      rest=n-last
    end
    if last>=min+ideal
      lastaverage=(ideal+(last-ideal)*(1-0.3*(2*ideal-last)/width))/last
    elsif last>=2*min
      lastaverage=[(min*(1-0.3*(ideal-min)/width)+(last-min)*(1-0.3*(ideal-last+min)/width))/last,
        1-0.3*(last-ideal)/width].max
    else
      lastaverage=1-0.3*(last-ideal)/width
    end
    return (rest+last*lastaverage)/n
  end
end


def is_within(time,length, prefs,activity)
	value = 0
  n=0
	prefs.each {
		|pref|
		if pref.interest > 0
			pref.times.each{
				|range|
				if range[:start] < time and range[:end] > time
          value += pref.interest*[pref.max_time,range[:end]-range[:start]].min
          n+=1
				end
			}
		end
	}
	return value*average_size_satisfaction(activity.min,activity.ideal,activity.max,n)
end


def get_within(time, prefs)
	ids = []
	prefs.each {
		|pref|
		if pref.interest > 0
			pref.times.each {
				|range|
				if range[:start] < time and range[:end] > time
					ids.push(pref.id)
				end
			}
		end
	}
	return ids
end


def range_span(range)
	return (range[:end]-range[:start])
end


def range_middle(range)
	return range[:start] + (range[:end]-range[:start])/2
end

  def choose_optimal
    #prefs = Preference.where(activity: self)
    
    prefs = Preference.where(activity_id: self)
    
	bestRanges = []
	
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
		bestRanges.push(bestRange)
        
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
    return bestRanges
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
