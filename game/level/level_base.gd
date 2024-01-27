class_name level_base extends Node

var game: Game

enum Moods { TIRED, SLEEPY, HEADEKY, LONLY }

# Called when the node enters the scene tree for the first time.
func _ready():
	game = get_tree().current_scene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func complete():
	game.state.complete_current_level()
	game.close_current_level()

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			game.close_current_level()
