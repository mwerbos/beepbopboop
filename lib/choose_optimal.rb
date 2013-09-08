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



