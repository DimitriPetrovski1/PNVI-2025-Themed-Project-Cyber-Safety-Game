extends CanvasLayer

@onready var animation_player := $ColorRect/AnimationPlayer
@onready var color_rect := $ColorRect
func _ready() -> void:
	visible = false

func transition_to(target_scene: String):
	visible = true	

	animation_player.play("fade")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target_scene)
	
	# 4. Fade to transparent (Reverse)
	# play_backwards starts from the current position or the end
	animation_player.play_backwards("fade")
	await animation_player.animation_finished
	visible =false
	# 5. Unblock mouse clicks so player can interact with the new scene
