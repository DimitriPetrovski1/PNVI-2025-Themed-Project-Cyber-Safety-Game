extends Button

signal showProblem()

func _pressed() -> void:
	showProblem.emit()
	disabled = true


func _on_gameplay_scene_1_new_character(_characterTexture: Texture2D) -> void:
	disabled=false
