extends Label


func _on_gameplay_scene_1_new_problem(problem: Problem) -> void:
	text = problem.get_short_description()
	
	
