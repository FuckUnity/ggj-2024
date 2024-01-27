class_name MainState extends Object

enum MiniGames { NONE, WINDOW, KITCHEN_COFFEE, COMPUTER, PLANTS, CAT_TREE }
enum MiniGameState { ACTIVE, BLOCKED, COMPLETED }
enum MainSceneObjects { WINDOW, COUCH, CHAIR }

var current_level_type: MiniGames
var current_level_ref: Node

var mainState = {
	MainSceneObjects.WINDOW: "closed",
	MainSceneObjects.COUCH: "empty",
	MainSceneObjects.CHAIR: "human_sad",
	'minigamesState': {
		MiniGames.WINDOW: MiniGameState.BLOCKED,
		MiniGames.KITCHEN_COFFEE: MiniGameState.BLOCKED,
		MiniGames.COMPUTER: MiniGameState.ACTIVE,
		MiniGames.PLANTS: MiniGameState.BLOCKED,
		MiniGames.CAT_TREE: MiniGameState.BLOCKED,
	}
}

func complete_current_level():
	var level = current_level_type
	
	match level:
		MiniGames.COMPUTER:
			mainState = {
				MainSceneObjects.WINDOW: "closed",
				MainSceneObjects.COUCH: "empty",
				MainSceneObjects.CHAIR: "human_happy",
				'minigamesState': {
					MiniGames.WINDOW: MiniGameState.BLOCKED,
					MiniGames.KITCHEN_COFFEE: MiniGameState.ACTIVE,
					MiniGames.COMPUTER: MiniGameState.COMPLETED,
					MiniGames.PLANTS: MiniGameState.BLOCKED,
					MiniGames.CAT_TREE: MiniGameState.BLOCKED,
				}
			}
		MiniGames.KITCHEN_COFFEE:
			mainState = {
				MainSceneObjects.WINDOW: "closed",
				MainSceneObjects.COUCH: "human",
				MainSceneObjects.CHAIR: "empty",
				'minigamesState': {
					MiniGames.WINDOW: MiniGameState.ACTIVE,
					MiniGames.KITCHEN_COFFEE: MiniGameState.COMPLETED,
					MiniGames.COMPUTER: MiniGameState.COMPLETED,
					MiniGames.PLANTS: MiniGameState.BLOCKED,
					MiniGames.CAT_TREE: MiniGameState.BLOCKED,
				}
			}
			
		MiniGames.WINDOW:
			mainState = {
				MainSceneObjects.WINDOW: "open",
				MainSceneObjects.COUCH: "human",
				MainSceneObjects.CHAIR: "empty",
				'minigamesState': {
					MiniGames.WINDOW: MiniGameState.COMPLETED,
					MiniGames.KITCHEN_COFFEE: MiniGameState.COMPLETED,
					MiniGames.COMPUTER: MiniGameState.COMPLETED,
					MiniGames.PLANTS: MiniGameState.BLOCKED,
					MiniGames.CAT_TREE: MiniGameState.ACTIVE,
				}
			}
		MiniGames.CAT_TREE:
			mainState = {
				MainSceneObjects.WINDOW: "open",
				MainSceneObjects.COUCH: "human",
				MainSceneObjects.CHAIR: "empty",
				'minigamesState': {
					MiniGames.WINDOW: MiniGameState.COMPLETED,
					MiniGames.KITCHEN_COFFEE: MiniGameState.COMPLETED,
					MiniGames.COMPUTER: MiniGameState.COMPLETED,
					MiniGames.PLANTS: MiniGameState.ACTIVE,
					MiniGames.CAT_TREE: MiniGameState.COMPLETED,
				}
			}
		MiniGames.PLANTS:
			mainState = {
				MainSceneObjects.WINDOW: "open",
				MainSceneObjects.COUCH: "human",
				MainSceneObjects.CHAIR: "empty",
				'minigamesState': {
					MiniGames.WINDOW: MiniGameState.COMPLETED,
					MiniGames.KITCHEN_COFFEE: MiniGameState.COMPLETED,
					MiniGames.COMPUTER: MiniGameState.COMPLETED,
					MiniGames.PLANTS: MiniGameState.COMPLETED,
					MiniGames.CAT_TREE: MiniGameState.COMPLETED,
				}
			}
			
	current_level_type = MiniGames.NONE
	current_level_ref = null

func set_level(level_type: MiniGames, level_ref: Node):
	current_level_type = level_type
	current_level_ref = level_ref
	
func is_open_level_allowed(level: MiniGames) -> bool:
	if level == MiniGames.NONE:
		return true
	
	return mainState.minigamesState[level] == MiniGameState.ACTIVE
