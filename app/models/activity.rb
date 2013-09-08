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
					puts length
          value += pref.interest*[pref.max_time,86400*length].min
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
		  puts "********************************"
		  puts "#{timeRange}: #{utility}"
		  puts "********************************"
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

  def check_and_create_event(pref)
    # Find the preference with the closest time range.
    min_time = pref.times.first[:start]
    puts "========================================"
    puts "This activity is:"
    puts self.inspect
    puts "========================================"
    puts "========================================"
    puts "The start time of this preference is:"
    puts min_time
    puts "========================================"
    # Check if an optimal schedule includes it. 
    included = false
    start_time = nil
    end_time = nil
    ranges = self.choose_optimal
    ranges.each do |range|
      if(range[:start]==min_time)
        included=true
        start_time = range[:start]
        end_time = range[:end]
        break
      end
    end
    puts "========================================"
    puts "The optimal ranges of times are:"
    puts ranges.inspect
    puts "========================================"

    puts "========================================"
    puts "The start time of the optimal range that matches it is:"
    puts start_time.inspect
    puts "========================================"
    # If it does, schedule the event!
    if(included)
      puts "THE EVENT IS BEING SCHEDULED!!!!!!!!!!!!!!!!!"
      @event = Event.new
      @event.activity = self
      @event.start_time = start_time
      @event.end_time = end_time
      # TODO notify users
      # TODO render these preferences invalid or whatever?
      prefs = Preference.where(activity_id: self)
      @event.users = []
      prefs.each do |pref|
        pref.event = @event
        @event.users.push(pref.user)
        pref.save
      end
      @event.save
    end
  end

end
