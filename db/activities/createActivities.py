import json

acts = {}

current = {}
current["label"] = "Soccer"
current["value"] = "Soccer"
current["type"] = "sport"
current["min"] = 6
current["ideal"] = 22
current["max"] = 30
acts["soccer"] = current

current = {}
current["label"] = "Football"
current["value"] = "Football"
current["type"] = "sport"
current["min"] = 6
current["ideal"] = 22
current["max"] = 30
acts["football"] = current

current = {}
current["label"] = "Volleyball"
current["value"] = "Volleyball"
current["type"] = "sport"
current["min"] = 6
current["ideal"] = 12
current["max"] = 20
acts["volleyball"] = current

current = {}
current["label"] = "Ultimate Frisbee"
current["value"] = "Ultimate Frisbee"
current["type"] = "sport"
current["min"] = 8
current["ideal"] = 14
current["max"] = 20
acts["ultimate"] = current

current = {}
current["label"] = "Tennis"
current["value"] = "Tennis"
current["type"] = "sport"
current["min"] = 2
current["ideal"] = 4
current["max"] = 8
acts["tennis"] = current

current = {}
current["label"] = "Ping Pong"
current["value"] = "Ping Pong"
current["type"] = "sport"
current["min"] = 2
current["ideal"] = 4
current["max"] = 8
acts["pingpong"] = current

current = {}
current["label"] = "Tossing Frisbee"
current["value"] = "Tossing Frisbee"
current["type"] = "exercise"
current["min"] = 3
current["ideal"] = 10
current["max"] = 20
acts["frisbee"] = current

current = {}
current["label"] = "Work out at Gym"
current["value"] = "Work out at Gym"
current["type"] = "exercise"
current["min"] = 3
current["ideal"] = 5
current["max"] = 10
acts["gym"] = current

current = {}
current["label"] = "Swimming"
current["value"] = "Swimming"
current["type"] = "exercise"
current["min"] = 3
current["ideal"] = 5
current["max"] = 10
acts["swimming"] = current

current = {}
current["label"] = "Rock Climbing"
current["value"] = "Rock Climbing"
current["type"] = "exercise"
current["min"] = 3
current["ideal"] = 5
current["max"] = 10
acts["swimming"] = current

current = {}
current["label"] = "Studying"
current["value"] = "Studying"
current["type"] = "education"
current["min"] = 6
current["ideal"] = 10
current["max"] = 12
acts["studying"] = current

current = {}
current["label"] = "Board Games"
current["value"] = "Board Games"
current["type"] = "games"
current["min"] = 3
current["ideal"] = 6
current["max"] = 8
acts["boardgames"] = current

current = {}
current["label"] = "Video Games"
current["value"] = "Video Games"
current["type"] = "games"
current["min"] = 3
current["ideal"] = 6
current["max"] = 8
acts["videogames"] = current

with open("activities_autocomplete.json", "w") as f:
    json.dump(acts, f)
