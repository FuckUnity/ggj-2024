class_name Game extends Node

var assets: Assets
var state: MainState

@export var init_level: MainState.MiniGames = MainState.MiniGames.NONE

func _init():
	assets = load("res://logic/Assets.gd").new()
	state = load("res://logic/main_state.gd").new()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	_init_level();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_double_esc -= _delta
	pass
	
func _init_level():
	_open_level(init_level)
	
func close_current_level():
	if !state.current_level_ref:
		return
		
	remove_child(state.current_level_ref)
	_open_level(MainState.MiniGames.NONE)
	
	
func _open_level(level: MainState.MiniGames):
	if !state.is_open_level_allowed(level):
		return;
	
	Input.set_custom_mouse_cursor(null)
	
	if state.current_level_type == MainState.MiniGames.NONE and state.current_level_ref:
		remove_child(state.current_level_ref)
	
	match level:
		MainState.MiniGames.NONE:
			state.set_level(level, assets.spawn_level(self, assets.template_level_main))
		MainState.MiniGames.WINDOW:
			state.set_level(level, assets.spawn_level(self, assets.template_level_window))
		MainState.MiniGames.CAT_TREE:
			state.set_level(level, assets.spawn_level(self, assets.template_level_cat_tree))
		MainState.MiniGames.COMPUTER:
			state.set_level(level, assets.spawn_level(self, assets.template_level_computer))
		MainState.MiniGames.KITCHEN_COFFEE:
			state.set_level(level, assets.spawn_level(self, assets.template_level_coffee))
		MainState.MiniGames.PLANTS:
			state.set_level(level, assets.spawn_level(self, assets.template_level_plants))
		MainState.MiniGames.FOOD_BOWL:
			state.set_level(level, assets.spawn_level(self, assets.template_level_food_bowl))
		MainState.MiniGames.CREDITS:
			state.set_level(level, assets.spawn_level(self, assets.template_level_credits))

var _double_esc: float = 0

func _unhandled_input(event):
	if Input.is_action_pressed("close"):
		if _double_esc > 0:
			get_tree().quit()
		else:
			_double_esc = 0.3
	
	if !OS.is_debug_build():
		return
	
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_0:
			state.debug_override_level_allowed = !state.debug_override_level_allowed
