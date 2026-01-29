extends TextureButton

signal showProblem()

func _pressed() -> void:
	showProblem.emit()
	disabled = true


func _on_gameplay_scene_1_new_problem(problem: Problem) -> void:
	disabled=false
