class_name level_base extends Node

var game: Game

enum Moods { TIRED, SLEEPY, HEADEKY, LONLY }

# Called when the node enters the scene tree for the first time.
func _ready():
	game = get_tree().current_scene if get_tree().current_scene is Game else null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func complete():
	game.state.complete_current_level()
	game.close_current_level()

func _unhandled_input(_event):
	if Input.is_action_pressed("close"):
		game.close_current_level()
