extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_start_pressed() -> void:
	print("Start pressed")
	Transition.transition_to("res://scenes/Day.tscn")

func _on_settings_pressed() -> void:
	print("Settings pressed")

func _on_exit_pressed() -> void:
	get_tree().quit()
	
