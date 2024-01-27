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

const window_closed = preload("res://assets/room_windows_closed.png")
const window_opened = preload("res://assets/room_windows_opened.png")

const mug_initial = preload("res://assets/Mug.png")
const mug_used = null

const couch_empty = null
const couch_human = preload("res://assets/couch_human.png")

const chair_empty = null
const chair_human_happy = preload("res://assets/chair_human_happy.png")
const chair_human_sad = preload("res://assets/chair_human_sad.png")

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
		
	match game.state.mainState[MainState.MainSceneObjects.WINDOW]:
		"closed":
			$"Control/AspectRatioContainer/TextureRectWindows".set_texture(window_closed)
		"open":
			$"Control/AspectRatioContainer/TextureRectWindows".set_texture(window_opened)
			
	match game.state.mainState[MainState.MainSceneObjects.COFFEE_CUP]:
		"initial":
			$"Control/AspectRatioContainer/TextureRectMug".set_texture(mug_initial)
		"used":
			$"Control/AspectRatioContainer/TextureRectMug".set_texture(mug_used)
			
	match game.state.mainState[MainState.MainSceneObjects.COUCH]:
		"empty":
			$"Control/AspectRatioContainer/TextureRectCouch".set_texture(couch_empty)
		"human":
			$"Control/AspectRatioContainer/TextureRectCouch".set_texture(couch_human)
			
	match game.state.mainState[MainState.MainSceneObjects.CHAIR]:
		"empty":
			$"Control/AspectRatioContainer/TextureRectChair".set_texture(chair_empty)
		"human_happy":
			$"Control/AspectRatioContainer/TextureRectChair".set_texture(chair_human_happy)
		"human_sad":
			$"Control/AspectRatioContainer/TextureRectChair".set_texture(chair_human_sad)
			

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

