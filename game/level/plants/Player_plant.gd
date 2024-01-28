extends CharacterBody2D

#player movement variables
@export var gravity = 200

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -200.0
@export var IDLE_ANIM_TIMEOUT = 2000

var idle_timer = null
var start_pos = null

var is_sleeping = false

func _ready():
	start_pos = position

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_anything_pressed() or not is_on_floor():
		idle_timer = null
		is_sleeping = false
		$purr.stop()

	# Handle jump.
	if Input.is_action_just_released("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	elif not is_on_floor():
		pass
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")

	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.flip_h = true
		$JumpIndicator.flipped = true
		if is_on_floor():
			$AnimatedSprite2D.play("walk")

	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.flip_h = false
		$JumpIndicator.flipped = false
		if is_on_floor():
			$AnimatedSprite2D.play("walk")

	#on idle if nothing is being pressed
	if is_on_floor() and !Input.is_anything_pressed():
		if idle_timer == null:
			idle_timer = Time.get_ticks_msec()
		elif Time.get_ticks_msec() - idle_timer > IDLE_ANIM_TIMEOUT && not is_sleeping:
			$AnimatedSprite2D.play("sleep")
			$purr.play()
			is_sleeping = true
			
		if not is_sleeping:
			$AnimatedSprite2D.play("default")

	move_and_slide()


func _on_plant_area_entered(body):
	$eat.play()

func _on_plant_dead_area_entered(body):
	position = start_pos

func on_pickup_wateringcan():
	$'..'.complete()
