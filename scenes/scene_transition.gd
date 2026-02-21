extends CanvasLayer

@onready var animation_player := $ColorRect/AnimationPlayer
@onready var color_rect := $ColorRect

func _ready() -> void:
	visible = false
	reparent(get_tree().root)

func transition_to(target_scene: String) -> void:
	visible = true
	
	# Fade TO black/opaque
	animation_player.play("fade")
	await animation_player.animation_finished
	
	# Change scene while faded out
	get_tree().change_scene_to_file(target_scene)
	
	# Wait a frame for new scene to initialize
	await get_tree().process_frame
	
	# Fade OUT to transparent
	animation_player.seek(animation_player.current_animation_length)
	animation_player.play_backwards("fade")
	await animation_player.animation_finished
	
	visible = false