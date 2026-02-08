extends Node

const DIALOGUE = {
	"intro_student": {
		"lines": [
			{"text": "Aurelia's neon fog bites like chalk.", "tone": "cold"},
			{"text": "Corrupted Student: 'Answer me... or distort.'", "tone": "tense"}
		],
		"choices": [
			{"text": "Offer empathy", "next": "intro_empathy", "mercy": 1, "empathy": true},
			{"text": "Dominate with formula", "next": "intro_control", "control": 1, "math": 1},
			{"text": "Chaos flourish", "next": "intro_chaos", "chaos": 1, "math": 2}
		]
	},
	"intro_empathy": {
		"lines": [
			{"text": "You soften the proof with warmth.", "tone": "warm"},
			{"text": "Corrupted Student hesitates.", "tone": "neutral"}
		],
		"end": true
	},
	"intro_control": {
		"lines": [
			{"text": "You enforce the optimum regime.", "tone": "cold"}
		],
		"end": true
	},
	"intro_chaos": {
		"lines": [
			{"text": "You distort the axioms and laugh.", "tone": "chaos"}
		],
		"end": true
	}
}

func get_node_data(key: String) -> Dictionary:
	return DIALOGUE.get(key, {})
