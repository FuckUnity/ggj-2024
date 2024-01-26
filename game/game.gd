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
	pass
	
func _init_level():
	_open_level(init_level)
	
func _close_level():
	if !state._current_level_ref:
		return
		
	remove_child(state._current_level_ref)
	
func _open_level(level: MainState.MiniGames):
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
