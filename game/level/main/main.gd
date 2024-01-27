extends level_base

const cursor_paw = preload("res://assets/tiny_paw.png")

const hover_window = preload("res://assets/Kitchen.png")
const hover_kitchen = preload("res://assets/Coffee_room.png")
const hover_cat_tree = preload("res://assets/Kratzbaum.png")
const hover_plant_0 = preload("res://assets/Kitchen.png")
const hover_plant_1 = preload("res://assets/Kitchen.png")
const hover_plant_2 = preload("res://assets/Kitchen.png")
const hover_plant_3 = preload("res://assets/Kitchen.png")
const hover_computer = preload("res://assets/Kitchen.png")

var buttons

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	Input.set_custom_mouse_cursor(cursor_paw, 0, Vector2(32, 32))
	
	buttons = [
		{ "button": $"Control/ButtonWindow",  "level": MainState.MiniGames.WINDOW, "hover": hover_window },
		{ "button": $"Control/ButtonKitchen", "level": MainState.MiniGames.KITCHEN_COFFEE, "hover": hover_kitchen },
		{ "button": $"Control/ButtonCatTree", "level": MainState.MiniGames.CAT_TREE, "hover": hover_cat_tree },
		{ "button": $"Control/ButtonPlant0", "level": MainState.MiniGames.PLANTS, "hover": hover_plant_0 },
		{ "button": $"Control/ButtonPlant1", "level": MainState.MiniGames.PLANTS, "hover": hover_plant_1 },
		{ "button": $"Control/ButtonPlant2", "level": MainState.MiniGames.PLANTS, "hover": hover_plant_2 },
		{ "button": $"Control/ButtonPlant3", "level": MainState.MiniGames.PLANTS, "hover": hover_plant_3 },
		{ "button": $"Control/ButtonComputer", "level": MainState.MiniGames.COMPUTER, "hover": hover_computer },
	]
	
	for b in buttons:
		_init_button(b)

func _init_button(b):
	b.button.pressed.connect(func(): game._open_level(b.level))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var button_hover = null
	for button in buttons: 
		if button.button.is_hovered():
			button_hover = button.hover
			
	# @todo set cursor to "CURSOR_POINTING_HAND"
	$"Control/AspectRatioContainer/TextureRectHover".set_texture(button_hover)

