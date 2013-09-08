#Preference:
#	id
#	user_id
#	activity_id
#	event_id
#	created_at
#	updated_at
#	times
#	repeats
#	interest

# require "date"

def is_within(time, prefs)
	value = 0
	prefs.each {
		|pref|
		if pref.interest > 0
			pref.times.each{
				|range|
				if range[:start] < time and range[:end] > time
					value += pref.interest
				end
			}
		end
	}
	return value
end

def create_stuff
	Preference.destroy_all
	
	p = Preference.create()
	p.activity_id=1
	p.times = [{start: DateTime.new(2001,1,1), end: DateTime.new(2001,4,1)}]
	p.interest = 1
	p.repeats = 1
	p.save()
	
	p = Preference.create()
	p.activity_id=1
	p.times = [{start: DateTime.new(2001,2,1), end: DateTime.new(2001,6,1)}]
	p.interest = 1
	p.repeats = 1
	p.save()
end


def choose_optimal(thisActivity)
	#prefs = Preference.where(activity = thisActivity)
	
	prefs = Preference.where(activity_id = thisActivity)
	
	allRanges = prefs.map { |pref| pref.times }
	
	relevantTimes = []
	
	puts "\nNumber of ranges:" + String(allRanges.size)
		
	allRanges.flatten.each {
		|range|
		relevantTimes.push(range[:start]).push(range[:end])
	}
	
	relevantTimes = relevantTimes.sort
	puts relevantTimes
	
	timeRanges = {}
	
	if relevantTimes.size > 0
		(relevantTimes.size-1).times {
			|i|
			timeRanges[{start:relevantTimes[i], end:relevantTimes[i+1]}] = 0
		}
		
		puts timeRanges
		
		timeRanges.keys.each {
			|timeRange|
			middleTime = timeRange[:start] + (timeRange[:end]-timeRange[:start])/2
			utility = is_within(middleTime, prefs)
			timeRanges[timeRange] = utility
		}
	end
	
	
	
end