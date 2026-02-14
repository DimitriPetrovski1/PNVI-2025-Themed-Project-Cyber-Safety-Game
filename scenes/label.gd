extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set initial text
	text = "$" + str(ShopGameData.money)
	
	# Listen for any future changes
	ShopGameData.money_changed.connect(_on_money_changed)

func _on_money_changed(new_amount):
	text = "$" + str(new_amount)
