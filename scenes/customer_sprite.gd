extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = null


func _on_gameplay_scene_1_new_character(characterTexture: Texture2D) -> void:
	texture = characterTexture
