class_name level_base extends Node

var game: Game

enum Moods { TIRED, SLEEPY, HEADEKY, LONLY }

# Called when the node enters the scene tree for the first time.
func _ready():
	game = get_tree().current_scene


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
