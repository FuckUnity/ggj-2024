class_name Kratzbaum extends level_base

var _completed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	if _completed:
		complete()

func set_complete():
	_completed = true
	
