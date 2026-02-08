extends CharacterBody2D

@export var speed := 180.0

@onready var sprite := $Sprite
@onready var interaction_area := $InteractionArea

func _ready() -> void:
	_setup_placeholder_if_needed()

func _physics_process(delta: float) -> void:
	var input_vector = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	velocity = input_vector.normalized() * speed
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact()

func _setup_placeholder_if_needed() -> void:
	if sprite.texture:
		return
	var image = Image.create(16, 16, false, Image.FORMAT_RGBA8)
	image.fill(Color(0.2, 0.9, 1.0, 1.0))
	var texture = ImageTexture.create_from_image(image)
	sprite.texture = texture

func interact() -> void:
	interaction_area.try_interact()
