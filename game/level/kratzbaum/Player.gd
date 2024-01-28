extends CharacterBody2D

#player movement variables
@export var gravity = 200

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -200.0
@export var JUMP_MAX = -350.0
@export var JUMP_BOOST_MULT = 1.6
@export var IDLE_ANIM_TIMEOUT = 2000

var jump_strength_charge = 0
var hast_jump_boost = false

var idle_timer = null
var start_pos = null

var is_sleeping = false

func _get_jump_str_max():
	if hast_jump_boost:
		return JUMP_MAX * JUMP_BOOST_MULT
	else:
		return JUMP_MAX

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
	if Input.is_action_pressed("jump") and is_on_floor():
		jump_strength_charge = max(jump_strength_charge + JUMP_VELOCITY * delta, _get_jump_str_max())
		$JumpIndicator.charge_amount = jump_strength_charge / _get_jump_str_max()

	if Input.is_action_just_released("jump") and is_on_floor():
		velocity.y = jump_strength_charge
		jump_strength_charge = 0
		$JumpIndicator.charge_amount = 0
		$meow.play()

	var direction = Input.get_axis("left", "right")
	if is_on_floor() and direction:
		velocity.x = direction * SPEED
	elif not is_on_floor():
		pass
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if not is_on_floor():
		if hast_jump_boost:
			$AnimatedSprite2D.play("jump_quick")
		else:
			$AnimatedSprite2D.play("jump")
	
	if not is_on_floor() and velocity.y < 0:
		$CollisionShape2D.set_deferred("disabled", true)
	else:
		$CollisionShape2D.set_deferred("disabled", false)

	if is_on_floor() and Input.is_action_pressed("left"):
		$AnimatedSprite2D.flip_h = true
		$JumpIndicator.flipped = true
		$AnimatedSprite2D.play("walk")

	#on right (add is_action_just_released so you continue running after jumping)
	if is_on_floor() and Input.is_action_pressed("right"):
		$AnimatedSprite2D.flip_h = false
		$JumpIndicator.flipped = false
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

func on_pickup(pickup: Pickup):
	pickup.queue_free()
	
	if(pickup.pickup_type == Pickup.PickupType.Toy):
		get_parent().set_complete()
	if(pickup.pickup_type == Pickup.PickupType.Boost):
		hast_jump_boost = true
		$eat.play()


func _on_bottom_border_entered(body):
	position = start_pos
