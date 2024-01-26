class_name level_base extends Node

var game: Game

enum Moods { TIRED, SLEEPY, HEADEKY, LONLY }

func _init():
	game = get_tree().current_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
