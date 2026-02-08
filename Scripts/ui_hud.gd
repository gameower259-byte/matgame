extends CanvasLayer

@onready var hp_label := $Stats/HPLabel
@onready var mental_label := $Stats/MentalLabel
@onready var moral_label := $Stats/MoralLabel

@onready var game_manager := get_tree().get_root().get_node("Main/GameManager")

func _ready() -> void:
	game_manager.state_changed.connect(_refresh)
	_refresh()

func _refresh() -> void:
	hp_label.text = "HP: %d" % game_manager.hp
	mental_label.text = "Mental: %d" % game_manager.mental
	moral_label.text = "Mercy: %d | Control: %d | Chaos: %d | Math: %d" % [
		game_manager.mercy_points,
		game_manager.control_points,
		game_manager.chaos_points,
		game_manager.math_overuse
	]
