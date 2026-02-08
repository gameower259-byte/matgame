extends Node

var phase := 0

func next_pattern() -> Dictionary:
	var pattern = {
		"name": "Infinite Series",
		"damage": 3,
		"speed": 300.0,
		"multiplier": 1.0
	}
	if phase == 1:
		pattern = {"name": "Paradox Spiral", "damage": 4, "speed": 320.0, "multiplier": 1.3}
	elif phase == 2:
		pattern = {"name": "Singularity Burst", "damage": 5, "speed": 340.0, "multiplier": 1.6}
	phase = (phase + 1) % 3
	return pattern
