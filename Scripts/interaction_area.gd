extends Area2D

func try_interact() -> void:
	for body in get_overlapping_bodies():
		if body.has_method("on_interact"):
			body.on_interact()
			return
	for area in get_overlapping_areas():
		if area.has_method("on_interact"):
			area.on_interact()
			return
