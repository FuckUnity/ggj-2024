extends level_base

const cursor_paw = preload("res://assets/tiny_paw.png")

const hover_kitchen = preload("res://assets/Coffee_room.png")
const hover_cat_tree = preload("res://assets/Kratzbaum.png")
const hover_computer = preload("res://assets/Desk.png")
const hover_easteregg = null
const hover_food_bowl = preload("res://assets/napf.png")

const window_closed = preload("res://assets/room_windows_closed.png")
const window_opened = preload("res://assets/room_windows_opened.png")

const mug_initial = preload("res://assets/Mug.png")
const mug_used = null

const plant_sad = preload("res://assets/Plants_sad.png")
const plant_happy = preload("res://assets/Plants_happy.png")

const couch_empty = null
const couch_human = preload("res://assets/couch_human.png")

const chair_empty = null
const chair_human_happy = preload("res://assets/chair_human_happy.png")
const chair_human_sad = preload("res://assets/chair_human_sad.png")

var completed = false
var buttons

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	Input.set_custom_mouse_cursor(cursor_paw, 0, Vector2(32, 32))
	
	buttons = [
		{ "button": $"Control/ButtonWindow",  "level": MainState.MiniGames.WINDOW, "hover": _hover_window() },
		{ "button": $"Control/ButtonKitchen", "level": MainState.MiniGames.KITCHEN_COFFEE, "hover": hover_kitchen },
		{ "button": $"Control/ButtonCatTree", "level": MainState.MiniGames.CAT_TREE, "hover": hover_cat_tree },
		{ "button": $"Control/ButtonPlant0", "level": MainState.MiniGames.PLANTS, "hover": _hover_plants() },
		{ "button": $"Control/ButtonPlant1", "level": MainState.MiniGames.PLANTS, "hover": _hover_plants() },
		{ "button": $"Control/ButtonPlant2", "level": MainState.MiniGames.PLANTS, "hover": _hover_plants() },
		{ "button": $"Control/ButtonPlant3", "level": MainState.MiniGames.PLANTS, "hover": _hover_plants() },
		{ "button": $"Control/ButtonComputer", "level": MainState.MiniGames.COMPUTER, "hover": hover_computer },
		{ "button": $"Control/ButtonFoodBowl", "level": MainState.MiniGames.FOOD_BOWL, "hover": hover_food_bowl },
		{ "button": $"Control/ButtonEasterEgg", "level": MainState.MiniGames.CREDITS, "hover": hover_easteregg },
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
			
	match game.state.mainState[MainState.MainSceneObjects.PLANTS]:
		"sad":
			$"Control/AspectRatioContainer/TextureRectPlants".set_texture(plant_sad)
		"happy":
			$"Control/AspectRatioContainer/TextureRectPlants".set_texture(plant_happy)
			
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
			
func _hover_plants():
	match game.state.mainState[MainState.MainSceneObjects.PLANTS]:
		"sad":
			return plant_sad
		"happy":
			return plant_happy
			
func _hover_window():
	match game.state.mainState[MainState.MainSceneObjects.WINDOW]:
		"closed":
			return window_closed
		"open":
			return window_opened
	

func _init_button(b):
	b.button.pressed.connect(func(): if b.level != null and _can_level_be_opened(b.level): game._open_level(b.level))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var button_hover = null
	for button in buttons: 
		if (button.level == null or _can_level_be_opened(button.level)) and button.button.is_hovered():
			button_hover = button.hover
			
	$"Control/AspectRatioContainer/TextureRectHover".set_texture(button_hover)
			
	if !completed:
		_check_completed()

func _can_level_be_opened(level) -> bool:
	return game.state.is_open_level_allowed(level)

func _check_completed():
	var _completed = true
	for level in MainState.MiniGames:
		_completed = completed and game.state.get_minigame_state()[level]
	
	if !completed and _completed:
		_show_game_completed()

func _show_game_completed():
	completed = true
	# @todo show completed dialog / speach-bubble?
