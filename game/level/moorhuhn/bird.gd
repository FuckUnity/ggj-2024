class_name Bird extends Node2D

enum State { FLYING, KILLED, FREE }

# left to right
var movement = Vector2(4.0, -1.0)
var state = State.FLYING

func set_start():
	var viewport = get_viewport()	
	var start_pos = Vector2(-viewport.size.x * 0.5 + 50.0, viewport.size.y * 0.5 - 50.0)
	
	set_position(start_pos)
	
func move():
	set_position(position + movement)
	
	_check_edge()
	
func _check_edge():
	var viewport = get_viewport().size * 0.5
	
	if position.y < -viewport.y:
		state = State.FREE
	
	if position.x > viewport.x:
		movement.x = -movement.x
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
