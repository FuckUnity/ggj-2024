extends Area2D

var HAND_SPEED = 100
var HAND_SPEED_RETREAT = 500
@export var HAND_MIN_EXTEND = 500
@export var HAND_MAX_EXTEND = 900
var HAND_NEXT_EXTEND = randi_range(HAND_MIN_EXTEND, HAND_MAX_EXTEND)
var HAND_POS = 0 # from 0 = neural (offscreen) to some position on screen
var HAND_ORIGIN

var extending = false
var retreating = false
var extendStart = 0
var retreatStart = 0


func _ready():
	HAND_ORIGIN = position.y

	extendStart = Time.get_ticks_msec() + randi_range(1,15) * 1000
	

	

func startExtending():
	extending = true
	retreating = false
	extendStart = 0
	# start retreating again after a few seconds
	
	HAND_SPEED = 200 * randf_range(1, 3)
	HAND_NEXT_EXTEND = randi_range(HAND_MIN_EXTEND, HAND_MAX_EXTEND)
	
	retreatStart = Time.get_ticks_msec() + randi_range(10,20) * 1000
	pass
	
	
func startRetreating():
	extending = false
	retreating = true
	
	# schedule the next extend
	extendStart = Time.get_ticks_msec() + randi_range(4,10) * 1000
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Time.get_ticks_msec() > extendStart && extendStart != 0:
		extendStart = 0
		startExtending()
	if Time.get_ticks_msec() > retreatStart && retreatStart != 0:
		retreatStart = 0
		startRetreating()
		
	if extending:
		HAND_POS += HAND_SPEED * delta
		HAND_POS = clamp(HAND_POS,0,HAND_NEXT_EXTEND)
		
		position.y = HAND_ORIGIN - HAND_POS
		if HAND_POS == HAND_NEXT_EXTEND:
			extending = false
	
	
	if retreating:
		HAND_POS -= HAND_SPEED_RETREAT * delta
		HAND_POS = clamp(HAND_POS,0,HAND_NEXT_EXTEND)
		
		position.y = HAND_ORIGIN - HAND_POS
		if HAND_POS == 0:
			retreating = false
	
func _physics_process(delta):

	for body in get_overlapping_bodies():
		if body.name == "Player" && !retreating:
			$Meow.play()
			startRetreating()
			owner.pet()

	
