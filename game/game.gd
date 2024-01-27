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
	
	match level:
		MainState.MiniGames.NONE:
			pass
		MainState.MiniGames.WINDOW:
			state.set_level(level, assets.spawn_level(self, assets.template_level_window))
		MainState.MiniGames.CAT_TREE:
			state.set_level(level, assets.spawn_level(self, assets.template_level_cat_tree))
		MainState.MiniGames.COMPUTER:
			state.set_level(level, assets.spawn_level(self, assets.template_level_window))
		MainState.MiniGames.KITCHEN_COFFEE:
			state.set_level(level, assets.spawn_level(self, assets.template_level_coffee))
		MainState.MiniGames.PLANTS:
			state.set_level(level, assets.spawn_level(self, assets.template_level_window))

var _double_esc: float = 0

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			if _double_esc > 0:
				get_tree().quit()
			else:
				_double_esc = 0.3
