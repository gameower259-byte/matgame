extends Node

# Global state for TEOREM – OPTIMUM REJİM
const SAVE_PATH := "user://save.json"

var mercy_points := 0
var control_points := 0
var chaos_points := 0
var math_overuse := 0

var hp := 20
var mental := 20

var kill_count := 0
var empathy_choices := 0
var timeline_flags: Dictionary = {}
var story_act := 1

signal state_changed

func _ready() -> void:
	load_game()
	_emit_state()

func adjust_moral(mercy_delta: int, control_delta: int, chaos_delta: int, math_delta: int) -> void:
	mercy_points += mercy_delta
	control_points += control_delta
	chaos_points += chaos_delta
	math_overuse += math_delta
	_emit_state()

func record_empathy(choice_tag: String) -> void:
	empathy_choices += 1
	timeline_flags["empathy_%s" % choice_tag] = true
	_emit_state()

func record_kill() -> void:
	kill_count += 1
	chaos_points += 1
	_emit_state()

func set_story_act(act: int) -> void:
	story_act = act
	_emit_state()

func _emit_state() -> void:
	emit_signal("state_changed")

func save_game() -> void:
	var payload = {
		"mercy_points": mercy_points,
		"control_points": control_points,
		"chaos_points": chaos_points,
		"math_overuse": math_overuse,
		"hp": hp,
		"mental": mental,
		"kill_count": kill_count,
		"empathy_choices": empathy_choices,
		"timeline_flags": timeline_flags,
		"story_act": story_act,
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(payload, "\t"))
		file.close()

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	if typeof(data) != TYPE_DICTIONARY:
		return
	mercy_points = data.get("mercy_points", mercy_points)
	control_points = data.get("control_points", control_points)
	chaos_points = data.get("chaos_points", chaos_points)
	math_overuse = data.get("math_overuse", math_overuse)
	hp = data.get("hp", hp)
	mental = data.get("mental", mental)
	kill_count = data.get("kill_count", kill_count)
	empathy_choices = data.get("empathy_choices", empathy_choices)
	timeline_flags = data.get("timeline_flags", timeline_flags)
	story_act = data.get("story_act", story_act)
