extends Node

func determine_ending(stats: Dictionary) -> String:
	var mercy = stats.get("mercy_points", 0)
	var control = stats.get("control_points", 0)
	var chaos = stats.get("chaos_points", 0)
	var math_overuse = stats.get("math_overuse", 0)
	if stats.get("hp", 1) <= 0:
		return "DEATH_" + str(randi_range(1, 6))
	if mercy >= 5 and chaos < 3:
		return "OPTIMUM_REGIME"
	if chaos >= 5 and control < 3:
		return "CHAOS_FREEDOM"
	if mercy >= 3 and control >= 3 and chaos >= 3 and math_overuse >= 5:
		return "PARADOX_TRUE"
	return "OPTIMUM_REGIME"
