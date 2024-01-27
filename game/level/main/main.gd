extends level_base

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if event.is_pressed():
		match event.keycode:
			KEY_1:
				game._open_level(MainState.MiniGames.CAT_TREE)
			KEY_2:
				game._open_level(MainState.MiniGames.KITCHEN_COFFEE)
			KEY_3:
				game._open_level(MainState.MiniGames.WINDOW)
			KEY_4:
				game._open_level(MainState.MiniGames.COMPUTER)
		
