extends Node2D

@onready var battle_ui := $BattleUI
@onready var announcement := battle_ui.get_node("Announcement")
@onready var game_manager := get_tree().get_root().get_node("Main/GameManager")

var enemy_phase := 0
var player_hp := 20
var mental := 20
var dodge_timer := 0.0

func _ready() -> void:
	battle_ui.get_node("Menu/SolveButton").pressed.connect(_on_solve)
	battle_ui.get_node("Menu/DistortButton").pressed.connect(_on_distort)
	battle_ui.get_node("Menu/EmpathyButton").pressed.connect(_on_empathy)
	battle_ui.get_node("Menu/ResetButton").pressed.connect(_on_reset)

func start_battle() -> void:
	visible = true
	enemy_phase = 0
	player_hp = game_manager.hp
	mental = game_manager.mental
	announcement.text = "Battle initiated. Survive the math.".to_upper()

func end_battle() -> void:
	game_manager.hp = player_hp
	game_manager.mental = mental
	game_manager.save_game()
	visible = false

func _process(delta: float) -> void:
	if not visible:
		return
	dodge_timer += delta
	if dodge_timer > 2.5:
		_dodge_phase()
		dodge_timer = 0.0

func _dodge_phase() -> void:
	match enemy_phase:
		0:
			announcement.text = "FRACTAL: recursive shards".to_upper()
			_apply_damage(1)
		1:
			announcement.text = "MATRIX: spread vectors".to_upper()
			_apply_damage(2)
		2:
			announcement.text = "LIMIT: slow phase".to_upper()
			_apply_damage(1)
		3:
			announcement.text = "INFINITE SERIES: escalate".to_upper()
			_apply_damage(3)
	enemy_phase = (enemy_phase + 1) % 4

func _apply_damage(amount: int) -> void:
	player_hp = max(0, player_hp - amount)
	mental = max(0, mental - int(amount / 2))
	if player_hp <= 0:
		announcement.text = "DEFEAT: Axiom collapse".to_upper()

func _on_solve() -> void:
	announcement.text = "SOLVE: You reduce entropy.".to_upper()
	game_manager.adjust_moral(1, 0, 0, 1)

func _on_distort() -> void:
	announcement.text = "DISTORT: You bend axioms.".to_upper()
	game_manager.adjust_moral(0, 0, 1, 2)

func _on_empathy() -> void:
	announcement.text = "EMPATHY: You validate pain.".to_upper()
	game_manager.adjust_moral(1, 0, 0, 0)
	game_manager.record_empathy("battle")

func _on_reset() -> void:
	announcement.text = "RESET: You rewind the proof.".to_upper()
	game_manager.adjust_moral(0, 1, 0, 1)
