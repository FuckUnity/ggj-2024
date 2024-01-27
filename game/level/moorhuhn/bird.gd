class_name Bird extends Node2D

enum State { INIT, FLYING, KILLED, FREE, DELETABLE }

# left to right
var movement = Vector2(4.0, -1.0)
var state = State.INIT

func set_start():
	state = State.INIT
	var viewport = get_viewport()	
	var start_pos = Vector2(-viewport.size.x * 0.5 + 50.0, viewport.size.y * 0.5 - 50.0)
	
	set_position(start_pos)
	state = State.FLYING
	
func move():
	set_position(position + movement)
	_check_edge()
	
func killed():
	state = State.KILLED
	movement = Vector2(0.0, 10.0)
	
func _check_edge():
	var viewport = get_viewport().size * 0.5
	
	if position.y < -viewport.y:
		state = State.FREE
	
	if position.x > viewport.x:
		movement.x = -movement.x
		
	if state == State.KILLED or state == State.FREE:
		if position.y < -viewport.y - 400 or position.y > viewport.y + 400:
			state = State.DELETABLE

# Hitpints 0 = Not Hit
#          3 = Bulls Eye 
func was_hit(pos: Vector2) -> int:
	if state != State.FLYING:
		return 0
		
	var dist = (position - pos).length()
	
	if dist < 15:
		return 3
	
	if dist < 30:
		return 2
		
	if dist < 100:
		return 1
		
	return 0
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
