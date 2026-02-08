extends Node

var phase := 0

func next_pattern() -> Dictionary:
	var pattern = {
		"name": "Echoing Matrices",
		"damage": 2,
		"speed": 240.0,
		"hint": "She knows your future choices."
	}
	if phase == 1:
		pattern = {"name": "Temporal Fold", "damage": 3, "speed": 280.0, "hint": "Timeline collapse."}
	phase = (phase + 1) % 2
	return pattern
