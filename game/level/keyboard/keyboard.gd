extends level_base

@export var TargetPets = 10
var currentPets = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func pet():
	currentPets += 1
	print(currentPets)
	if currentPets == TargetPets:
		print("complete")
		complete()
		
