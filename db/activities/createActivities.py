import json

acts = {}

current = {}
current["name"] = "Soccer"
current["type"] = "sport"
current["min"] = 6
current["ideal"] = 22
current["max"] = 30
acts["soccer"] = current

current = {}
current["name"] = "Football"
current["type"] = "sport"
current["min"] = 6
current["ideal"] = 22
current["max"] = 30
acts["football"] = current

current = {}
current["name"] = "Volleyball"
current["type"] = "sport"
current["min"] = 6
current["ideal"] = 12
current["max"] = 20
acts["volleyball"] = current

current = {}
current["name"] = "Ultimate Frisbee"
current["type"] = "sport"
current["min"] = 8
current["ideal"] = 14
current["max"] = 20
acts["ultimate"] = current

current = {}
current["name"] = "Tennis"
current["type"] = "sport"
current["min"] = 2
current["ideal"] = 4
current["max"] = 8
acts["tennis"] = current

current = {}
current["name"] = "Ping Pong"
current["type"] = "sport"
current["min"] = 2
current["ideal"] = 4
current["max"] = 8
acts["pingpong"] = current

current = {}
current["name"] = "Tossing Frisbee"
current["type"] = "exercise"
current["min"] = 3
current["ideal"] = 10
current["max"] = 20
acts["frisbee"] = current

current = {}
current["name"] = "Work out at Gym"
current["type"] = "exercise"
current["min"] = 3
current["ideal"] = 5
current["max"] = 10
acts["gym"] = current

current = {}
current["name"] = "Swimming"
current["type"] = "exercise"
current["min"] = 3
current["ideal"] = 5
current["max"] = 10
acts["swimming"] = current

current = {}
current["name"] = "Rock Climbing"
current["type"] = "exercise"
current["min"] = 3
current["ideal"] = 5
current["max"] = 10
acts["swimming"] = current

current = {}
current["name"] = "Studying"
current["type"] = "education"
current["min"] = 6
current["ideal"] = 10
current["max"] = 12
acts["studying"] = current

current = {}
current["name"] = "Board Games"
current["type"] = "games"
current["min"] = 3
current["ideal"] = 6
current["max"] = 8
acts["boardgames"] = current

current = {}
current["name"] = "Video Games"
current["type"] = "games"
current["min"] = 3
current["ideal"] = 6
current["max"] = 8
acts["videogames"] = current

with open("activites.json", "w") as f:
    json.dump(acts, f)