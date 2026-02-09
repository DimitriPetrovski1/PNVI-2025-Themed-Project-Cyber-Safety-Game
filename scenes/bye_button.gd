extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	disabled = true
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_text_bubble_text_finished_thank_you_message() -> void:
	visible = true
	disabled = false
	
func _pressed() -> void:
	disabled = true
	visible = false
