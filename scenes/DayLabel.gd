extends Label

func _ready() -> void:
	
	
	# 1. Safety check to prevent the 'null instance' crash
	

	# 2. Convert integer to string using str()
	text = "Day " + str(GameInfo.day_count)
	
	# 3. Modify and save using ResourceSaver
	GameInfo.increment()
	await get_tree().create_timer(2.0).timeout
	
	Transition.transition_to("res://scenes/gameplay_scene_1.tscn")
