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
