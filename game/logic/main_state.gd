class_name MainState extends Object

enum MiniGames { NONE, WINDOW, KITCHEN_COFFEE, COMPUTER, PLANTS, CAT_TREE }
enum MiniGameState { ACTIVE, BLOCKED, COMPLETED }
enum MainSceneObjects { WINDOW, COUCH, CHAIR }

var current_level_type: MiniGames
var current_level_ref: Node

var minigamesState = {
	MiniGames.WINDOW: MiniGameState.ACTIVE,
	MiniGames.KITCHEN_COFFEE: MiniGameState.ACTIVE,
	MiniGames.COMPUTER: MiniGameState.BLOCKED,
	MiniGames.PLANTS: MiniGameState.BLOCKED,
	MiniGames.CAT_TREE: MiniGameState.ACTIVE,
}

var mainState = {
	MainSceneObjects.WINDOW: "closed",
	MainSceneObjects.COUCH: "human",
	MainSceneObjects.CHAIR: "human"
}

func activate_level(level: MiniGames):
	if minigamesState[level] == MiniGameState.BLOCKED:
		minigamesState[level] = MiniGameState.ACTIVE

func complete_current_level():
	var level = current_level_type
	minigamesState[level] = MiniGameState.COMPLETED
	
	match level:
		MiniGames.KITCHEN_COFFEE:
			activate_level(MiniGames.COMPUTER)
			mainState[MainSceneObjects.CHAIR] = "empty"
			
		MiniGames.PLANTS:
			activate_level(MiniGames.WINDOW)
			
		MiniGames.CAT_TREE:
			mainState[MainSceneObjects.COUCH] = "empty"
			
		MiniGames.WINDOW:
			mainState[MainSceneObjects.WINDOW] = "opened"
			
		# @todo

func set_level(level_type: MiniGames, level_ref: Node):
	current_level_type = level_type
	current_level_ref = level_ref
	
func is_open_level_allowed(level: MiniGames) -> bool:
	if level == MiniGames.NONE:
		return true
	
	return minigamesState[level] == MiniGameState.ACTIVE
