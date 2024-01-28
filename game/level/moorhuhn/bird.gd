class_name Bird extends Node2D

enum State { INIT, FLYING, KILLED, FREE, DELETABLE }

# left to right
var movement: Vector2
var state: State = State.INIT
var _rng: RandomNumberGenerator

func set_start(rng: RandomNumberGenerator):
	_rng = rng
	var side = _get_start_side()
	set_position(_get_start_position(side))
	movement = _get_start_movement(side)
	state = State.FLYING

func _physics_process(delta):
	set_position(position + movement * delta)
	_check_edge()

func killed():
	state = State.KILLED
	movement = Vector2(0.0, 600.0)

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

func _check_edge():
	var viewport = get_viewport().size * 0.5
	
	if position.y < -viewport.y:
		state = State.FREE
	
	if position.x > viewport.x:
		movement.x = -movement.x
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
		
	if state == State.KILLED or state == State.FREE:
		if position.y < -viewport.y - 400 or position.y > viewport.y + 400:
			state = State.DELETABLE

func _get_start_side() -> float:
	return -1.0 if _rng.randi_range(0, 1) > 0 else 1.0

func _get_start_position(side: float) -> Vector2:
	var viewport = get_viewport().size * 0.5
	var height = _rng.randf_range(100, viewport.y - 50)

	return Vector2((viewport.x - 50.0) * side, height)

func _get_start_movement(side: float) -> Vector2:
	var speed = _rng.randf_range(180.0, 300.0)
	var angle = _rng.randf_range(-85.0, -60.0)

	$AnimatedSprite2D.flip_h = side > 0
	$AnimatedSprite2D.play()
	
	return Vector2(speed * -side, angle)
