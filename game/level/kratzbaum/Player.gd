extends CharacterBody2D

#player movement variables
@export var gravity = 200

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -200.0
@export var JUMP_MAX = -400.0

var jump_strength_charge = 0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		jump_strength_charge = max(jump_strength_charge + JUMP_VELOCITY * delta, JUMP_MAX)
		$JumpIndicator.charge_amount = jump_strength_charge / JUMP_MAX

	if Input.is_action_just_released("jump") and is_on_floor():
		velocity.y = jump_strength_charge
		jump_strength_charge = 0
		$JumpIndicator.charge_amount = 0

	var direction = Input.get_axis("left", "right")
	if is_on_floor() and direction:
		velocity.x = direction * SPEED
	elif not is_on_floor():
		pass
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if not is_on_floor():
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
		$AnimatedSprite2D.play("default")
		
	move_and_slide()

func on_pickup(pickup: Pickup):
	pickup.queue_free()
	
	if(pickup.pickup_type == Pickup.PickupType.Toy):
		get_parent().complete()
	if(pickup.pickup_type == Pickup.PickupType.Boost):
		JUMP_MAX = JUMP_MAX * 2
