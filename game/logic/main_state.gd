class_name MainState extends Object

enum MiniGames { NONE, WINDOW, KITCHEN_COFFEE, COMPUTER, PLANTS, CAT_TREE }

var current_level_type: MiniGames
var current_level_ref: Node


func set_level(level_type: MiniGames, level_ref: Node):
	current_level_type = level_type
	current_level_ref = level_ref
