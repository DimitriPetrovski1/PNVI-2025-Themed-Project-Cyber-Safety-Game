extends Control
@export var frame_texture: Texture2D = preload("res://assets/UI/ShopItemFrame.png")

@export var accessories: Array[AccessoryData] = []
# Drag your frame image (the box/background) here in the inspector

@onready var grid = $"Background Back Button/TextureRect/ScrollContainer/GridContainer"

signal accessory_updated

func _ready():
	# 1. Load the accessories from the folder
	var folder = "res://scenes/shop/accessories/"
	var dir = DirAccess.open(folder)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):
				var res = load(folder + file_name)
				if res:
					accessories.append(res)
			file_name = dir.get_next()
		dir.list_dir_end()

	# 2. Populate shop
	for accessory in accessories:
		# Create a Horizontal wrapper for each shop item
		var item_container = HBoxContainer.new()
		item_container.add_theme_constant_override("separation", 15)
		item_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		grid.add_child(item_container)

		# --- THE FRAME & ACCESSORY STACK ---
		var frame_anchor = Control.new()
		frame_anchor.custom_minimum_size = Vector2(110, 140)
		item_container.add_child(frame_anchor)

		# The Background Frame
		var bg_frame = TextureRect.new()
		bg_frame.texture = frame_texture
		bg_frame.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		bg_frame.stretch_mode = TextureRect.STRETCH_SCALE
		bg_frame.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		frame_anchor.add_child(bg_frame)

		# The Accessory (The "No-Code" Centering way)
		var tex_rect = TextureRect.new()
		tex_rect.texture = accessory.texture
		tex_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		# This mode centers the image within the node's bounds automatically
		tex_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		# We make the node fill the entire frame_anchor area
		tex_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		# Optional: Add a small margin so the accessory doesn't touch the frame edges
		tex_rect.offset_left = 10
		tex_rect.offset_top = 10
		tex_rect.offset_right = -10
		tex_rect.offset_bottom = -10
		frame_anchor.add_child(tex_rect)

		# --- THE BUTTON ---
		var btn = Button.new()
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER 
		btn.custom_minimum_size.y = 80 
		btn.set_meta("accessory", accessory)
		btn.pressed.connect(_on_shop_item_pressed.bind(btn))
		item_container.add_child(btn)
	
	_update_buttons()

func _on_shop_item_pressed(btn: Button):
	var accessory: AccessoryData = btn.get_meta("accessory")
	
	if accessory.id in ShopGameData.owned_items:
		if accessory.id in ShopGameData.equipped_items:
			ShopGameData.unequip_item(accessory.id)
		else:
			ShopGameData.equip_item(accessory.id)
	else:
		ShopGameData.buy_item(accessory.id, accessory.price)
	
	_update_buttons()
	accessory_updated.emit()

func _update_buttons():
	for item_container in grid.get_children():
		# The button is the second child of the HBox
		var btn = item_container.get_child(1)
		var accessory: AccessoryData = btn.get_meta("accessory")
		
		if accessory.id in ShopGameData.owned_items:
			if accessory.id in ShopGameData.equipped_items:
				btn.text = accessory.name + "\n(Equipped)"
			else:
				btn.text = accessory.name + "\n(Owned)"
		else:
			btn.text = accessory.name + "\n$" + str(accessory.price)

func _on_color_rect_pressed() -> void:
	queue_free()
