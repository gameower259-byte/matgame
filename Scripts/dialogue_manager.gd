extends Node

@onready var ui := get_parent().get_node("UIHud")
@onready var text_label := ui.get_node("DialoguePanel/DialogueText")
@onready var game_manager := get_tree().get_root().get_node("Main/GameManager")

var dialogue_data: Node
var current_node: Dictionary = {}
var line_index := 0
var emotional_tone := "neutral"
var active := false

func _ready() -> void:
	dialogue_data = load("res://Scripts/dialogue_data.gd").new()

func start_dialogue(key: String) -> void:
	current_node = dialogue_data.get_node_data(key)
	line_index = 0
	active = true
	_show_line()

func _show_line() -> void:
	if current_node.is_empty():
		text_label.text = ""
		return
	var lines = current_node.get("lines", [])
	if line_index >= lines.size():
		_handle_end_or_choices()
		return
	var line = lines[line_index]
	emotional_tone = line.get("tone", "neutral")
	text_label.text = line.get("text", "")
	line_index += 1

func advance_dialogue() -> void:
	_show_line()

func _handle_end_or_choices() -> void:
	if current_node.get("end", false):
		text_label.text = ""
		active = false
		return
	var choices = current_node.get("choices", [])
	if choices.is_empty():
		text_label.text = ""
		active = false
		return
	# Minimal choice auto-pick: choose first choice, intended to be replaced by UI selection.
	_apply_choice(choices[0])

func _apply_choice(choice: Dictionary) -> void:
	game_manager.adjust_moral(
		choice.get("mercy", 0),
		choice.get("control", 0),
		choice.get("chaos", 0),
		choice.get("math", 0)
	)
	if choice.get("empathy", false):
		game_manager.record_empathy(choice.get("text", ""))
	start_dialogue(choice.get("next", ""))

func _unhandled_input(event: InputEvent) -> void:
	if not active:
		return
	if event.is_action_pressed("ui_accept"):
		advance_dialogue()
