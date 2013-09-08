# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

file = File.open("./db/activities/activities.json", "rb")
contents = file.read
json = JSON.load(contents)

json.keys.each {
	|key|
	act = Activity.create()
	json[key].each {
		|category, value|
		act[category.to_sym] = value
	}
	act.save()
}



names = ["Waltraud",
"Georgiann",
"Jacqulyn",
"Billie",
"Annita",
"Dorthy",
"Richard",
"Harley",
"Zola",
"Claretta",
"Leoma",
"Dawna",
"Tiny",
"Trula",
"Theodore",
"Jolanda",
"Bok",
"Bao",
"Patrica",
"Ardelle",
"Ferdinand",
"Rubie",
"Laurice",
"Cira",
"Chaya",
"Catrice",
"Stefan",
"Leandro",
"Makeda",
"Andra"]

names.each {
	|name|
	params={}
	params[:user] = { username: name, email: name + "@mailcatch.com", password: "hello", password_confirmation: "hello" }
	user = User.new(params[:user])
	
	user.save()
}

soccerTimes = [
[1, DateTime.new(2013, 9, 12, 14, 15, 0, '-4'), DateTime.new(2013, 9, 12, 18, 45, 0, '-4')],
[2, DateTime.new(2013, 9, 12, 13, 05, 0, '-4'), DateTime.new(2013, 9, 12, 18, 35, 0, '-4')],
[3, DateTime.new(2013, 9, 12, 16, 20, 0, '-4'), DateTime.new(2013, 9, 12, 18, 40, 0, '-4')],
[4, DateTime.new(2013, 9, 12, 18, 10, 0, '-4'), DateTime.new(2013, 9, 12, 21, 30, 0, '-4')],
[5, DateTime.new(2013, 9, 12, 14, 15, 0, '-4'), DateTime.new(2013, 9, 12, 19, 10, 0, '-4')],
[6, DateTime.new(2013, 9, 12, 13, 15, 0, '-4'), DateTime.new(2013, 9, 12, 15, 30, 0, '-4')],
[7, DateTime.new(2013, 9, 12, 12, 15, 0, '-4'), DateTime.new(2013, 9, 12, 18, 45, 0, '-4')],
[8, DateTime.new(2013, 9, 12, 14, 15, 0, '-4'), DateTime.new(2013, 9, 12, 18, 15, 0, '-4')],
[9, DateTime.new(2013, 9, 12, 13, 15, 0, '-4'), DateTime.new(2013, 9, 12, 17, 40, 0, '-4')],
[10, DateTime.new(2013, 9, 12, 11, 15, 0, '-4'), DateTime.new(2013, 9, 12, 16, 25, 0, '-4')],
[11, DateTime.new(2013, 9, 12, 15, 15, 0, '-4'), DateTime.new(2013, 9, 12, 19, 35, 0, '-4')],
[12, DateTime.new(2013, 9, 12, 14, 15, 0, '-4'), DateTime.new(2013, 9, 12, 18, 40, 0, '-4')],
[13, DateTime.new(2013, 9, 12, 12, 15, 0, '-4'), DateTime.new(2013, 9, 12, 19, 30, 0, '-4')]
]

soccerId = Activity.where(:name => "Soccer")[0]

soccerTimes.each {
	|player|
	
	pref = Preference.create()
	pref.user = User.find(player[0])
	pref.activity = soccerId
	pref.interest = 1.0
	pref.repeats = 1
	
	pref.times = [{start: player[1], end: player[2]}]
	
	pref.save()
}




