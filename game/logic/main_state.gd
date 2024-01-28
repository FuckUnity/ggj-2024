class_name MainState extends Object

enum MiniGames { NONE, WINDOW, KITCHEN_COFFEE, COMPUTER, PLANTS, CAT_TREE, FOOD_BOWL, CREDITS }
enum MiniGameState { ACTIVE, BLOCKED, COMPLETED }
enum MainSceneObjects { WINDOW, COUCH, CHAIR, COFFEE_CUP, PLANTS }

var current_level_type: MiniGames
var current_level_ref: Node
var debug_override_level_allowed = false

var mainState = {
	MainSceneObjects.WINDOW: "closed",
	MainSceneObjects.COUCH: "empty",
	MainSceneObjects.CHAIR: "human_sad",
	MainSceneObjects.COFFEE_CUP: "initial",
	MainSceneObjects.PLANTS: "sad",
	'minigamesState': {
		MiniGames.WINDOW: MiniGameState.BLOCKED,
		MiniGames.KITCHEN_COFFEE: MiniGameState.BLOCKED,
		MiniGames.COMPUTER: MiniGameState.ACTIVE,
		MiniGames.PLANTS: MiniGameState.BLOCKED,
		MiniGames.CAT_TREE: MiniGameState.BLOCKED,
		MiniGames.FOOD_BOWL: MiniGameState.BLOCKED,
	},
	'emotions': [
		'sad',
		'lonely',
		'bad_air',
		'bored',
		'tired'
	]
}

func get_emotions():
	return mainState.emotions

func get_minigame_state():
	return mainState.minigamesState

func get_object_state(object: MainSceneObjects):
	return mainState[object]

func complete_current_level():
	var level = current_level_type
	
	match level:
		MiniGames.COMPUTER:
			mainState = {
				MainSceneObjects.WINDOW: "closed",
				MainSceneObjects.COUCH: "empty",
				MainSceneObjects.CHAIR: "human_happy",
				MainSceneObjects.COFFEE_CUP: "initial",
				MainSceneObjects.PLANTS: "sad",
				'minigamesState': {
					MiniGames.WINDOW: MiniGameState.BLOCKED,
					MiniGames.KITCHEN_COFFEE: MiniGameState.ACTIVE,
					MiniGames.COMPUTER: MiniGameState.COMPLETED,
					MiniGames.PLANTS: MiniGameState.BLOCKED,
					MiniGames.CAT_TREE: MiniGameState.BLOCKED,
					MiniGames.FOOD_BOWL: MiniGameState.BLOCKED,
				},
				'emotions': [
					'sad',
					'bad_air',
					'bored',
					'tired'
				]
			}
		MiniGames.KITCHEN_COFFEE:
			mainState = {
				MainSceneObjects.WINDOW: "closed",
				MainSceneObjects.COUCH: "human",
				MainSceneObjects.CHAIR: "empty",
				MainSceneObjects.COFFEE_CUP: "used",
				MainSceneObjects.PLANTS: "sad",
				'minigamesState': {
					MiniGames.WINDOW: MiniGameState.ACTIVE,
					MiniGames.KITCHEN_COFFEE: MiniGameState.COMPLETED,
					MiniGames.COMPUTER: MiniGameState.COMPLETED,
					MiniGames.PLANTS: MiniGameState.BLOCKED,
					MiniGames.CAT_TREE: MiniGameState.BLOCKED,
					MiniGames.FOOD_BOWL: MiniGameState.BLOCKED,
				},
				'emotions': [
					'sad',
					'bad_air',
					'bored'
				]
			}
			
		MiniGames.WINDOW:
			mainState = {
				MainSceneObjects.WINDOW: "open",
				MainSceneObjects.COUCH: "human",
				MainSceneObjects.CHAIR: "empty",
				MainSceneObjects.COFFEE_CUP: "used",
				MainSceneObjects.PLANTS: "sad",
				'minigamesState': {
					MiniGames.WINDOW: MiniGameState.COMPLETED,
					MiniGames.KITCHEN_COFFEE: MiniGameState.COMPLETED,
					MiniGames.COMPUTER: MiniGameState.COMPLETED,
					MiniGames.PLANTS: MiniGameState.BLOCKED,
					MiniGames.CAT_TREE: MiniGameState.ACTIVE,
					MiniGames.FOOD_BOWL: MiniGameState.BLOCKED,
				},
				'emotions': [
					'sad',
					'bored'
				]
			}
		MiniGames.CAT_TREE:
			mainState = {
				MainSceneObjects.WINDOW: "open",
				MainSceneObjects.COUCH: "human",
				MainSceneObjects.CHAIR: "empty",
				MainSceneObjects.COFFEE_CUP: "used",
				MainSceneObjects.PLANTS: "sad",
				'minigamesState': {
					MiniGames.WINDOW: MiniGameState.COMPLETED,
					MiniGames.KITCHEN_COFFEE: MiniGameState.COMPLETED,
					MiniGames.COMPUTER: MiniGameState.COMPLETED,
					MiniGames.PLANTS: MiniGameState.ACTIVE,
					MiniGames.CAT_TREE: MiniGameState.COMPLETED,
					MiniGames.FOOD_BOWL: MiniGameState.BLOCKED,
				},
				'emotions': [
					'sad'
				]
			}
		MiniGames.PLANTS:
			mainState = {
				MainSceneObjects.WINDOW: "open",
				MainSceneObjects.COUCH: "human",
				MainSceneObjects.CHAIR: "empty",
				MainSceneObjects.COFFEE_CUP: "used",
				MainSceneObjects.PLANTS: "happy",
				'minigamesState': {
					MiniGames.WINDOW: MiniGameState.COMPLETED,
					MiniGames.KITCHEN_COFFEE: MiniGameState.COMPLETED,
					MiniGames.COMPUTER: MiniGameState.COMPLETED,
					MiniGames.PLANTS: MiniGameState.COMPLETED,
					MiniGames.CAT_TREE: MiniGameState.COMPLETED,
					MiniGames.FOOD_BOWL: MiniGameState.ACTIVE,
				},
				'emotions': []
			}
		MiniGames.FOOD_BOWL:
			mainState = {
				MainSceneObjects.WINDOW: "open",
				MainSceneObjects.COUCH: "human",
				MainSceneObjects.CHAIR: "empty",
				MainSceneObjects.COFFEE_CUP: "used",
				MainSceneObjects.PLANTS: "happy",
				'minigamesState': {
					MiniGames.WINDOW: MiniGameState.COMPLETED,
					MiniGames.KITCHEN_COFFEE: MiniGameState.COMPLETED,
					MiniGames.COMPUTER: MiniGameState.COMPLETED,
					MiniGames.PLANTS: MiniGameState.COMPLETED,
					MiniGames.CAT_TREE: MiniGameState.COMPLETED,
					MiniGames.FOOD_BOWL: MiniGameState.COMPLETED,
				},
				'emotions': []
			}
	
	# current_level is set by set_level
	#   current_level_type = MiniGames.NONE
	#   current_level_ref = null

func set_level(level_type: MiniGames, level_ref: Node):
	current_level_type = level_type
	current_level_ref = level_ref
	
func is_open_level_allowed(level: MiniGames) -> bool:
	if level == MiniGames.NONE or level == MiniGames.CREDITS or debug_override_level_allowed:
		return true
	
	return mainState.minigamesState[level] == MiniGameState.ACTIVE or mainState.minigamesState[level] == MiniGameState.COMPLETED
