extends CharacterBody2D

#player movement variables
@export var gravity = 0

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -200.0
@export var JUMP_MAX = -400.0


func _ready():
	$AnimatedSprite2D/ColorRect.color = Color(0,0,0,0)

func _physics_process(delta):

	# Handle jump.
	if Input.is_action_pressed("jump"):
		pass
		
	if Input.is_action_just_released("jump"):
		pass

	var directionX = Input.get_axis("left", "right")
	var directionY = Input.get_axis("up", "down")
	velocity = Vector2(directionX, directionY).normalized() * SPEED
	
		

	#$CollisionShape2D.set_deferred("disabled", false)
		
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walk")

	#on right (add is_action_just_released so you continue running after jumping)
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk")

	#on idle if nothing is being pressed
	if is_on_floor() and !Input.is_anything_pressed():
		$AnimatedSprite2D.play("default")
		
	move_and_slide()
	