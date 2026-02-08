extends Area2D

@export var dialogue_key := "intro_student"

func on_interact() -> void:
	var manager = get_tree().get_root().get_node("Main/Overworld/DialogueManager")
	manager.start_dialogue(dialogue_key)
