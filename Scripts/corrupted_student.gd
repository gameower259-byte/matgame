extends Node

var phase := 0

func next_pattern() -> Dictionary:
	var pattern = {
		"name": "Fractal",
		"damage": 1,
		"speed": 220.0
	}
	if phase == 1:
		pattern = {"name": "Matrix Spread", "damage": 2, "speed": 260.0}
	elif phase == 2:
		pattern = {"name": "Limit Slow", "damage": 1, "speed": 160.0}
	phase = (phase + 1) % 3
	return pattern
