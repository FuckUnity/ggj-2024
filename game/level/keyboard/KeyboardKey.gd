extends Area2D

@export var KeyboardKey = ""
var KeyboardSpeed = 100
var lastPress = Time.get_ticks_msec()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body.name == "Player":
			if lastPress + KeyboardSpeed < Time.get_ticks_msec():
				lastPress = Time.get_ticks_msec()
				var label = owner.get_node("Textpanel")

				label.text += KeyboardKey
				if body.isMoving:
					$Click.play()
				
