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
#	min
#	ideal
#	max
#	max_time


def create_stuff
	Preference.destroy_all
	
	p = Preference.create()
	p.activity_id=1
	p.times = [{start: DateTime.new(2001,1,1), end: DateTime.new(2001,4,1)}]
  p.user_id=1
	p.save()
	
	p = Preference.create()
	p.activity_id=1
	p.times = [{start: DateTime.new(2001,2,1), end: DateTime.new(2001,6,1)}]
  p.user_id=1
	p.save()
	
	p = Preference.create()
	p.activity_id=1
	p.times = [{start: DateTime.new(2001,1,1), end: DateTime.new(2001,8,1)}]
  p.user_id=1
	p.save()
	
	p = Preference.create()
	p.activity_id=1
	p.times = [{start: DateTime.new(2001,9,1), end: DateTime.new(2001,12,1)}]
  p.user_id=1
	p.save()
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



