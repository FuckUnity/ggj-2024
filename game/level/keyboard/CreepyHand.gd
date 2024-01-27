extends StaticBody2D

var HAND_SPEED = 100
var HAND_SPEED_RETREAT = 500
const HAND_MAX_EXTEND = 700
var HAND_POS = 0 # from 0 = neural (offscreen) to some position on screen
var HAND_ORIGIN

var extending = false
var retreating = false
var extendStart = 0
var retreatStart = 0


func _ready():
	HAND_ORIGIN = $AnimatedSprite2D.position.y

	HAND_SPEED = HAND_SPEED * randf_range(1, 1.5)
	extendStart = Time.get_ticks_msec() + randi_range(1,5) * 1000

func startExtending():
	extending = true
	retreating = false
	extendStart = 0
	# start retreating again after a few seconds
	retreatStart = Time.get_ticks_msec() + randi_range(10,20) * 1000
	pass
	
	
func startRetreating():
	extending = false
	retreating = true
	
	# schedule the next extend
	extendStart = Time.get_ticks_msec() + randi_range(10,15) * 1000
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if name == "South_Left":
		print(Time.get_ticks_msec() - extendStart)
	if Time.get_ticks_msec() > extendStart && extendStart != 0:
		extendStart = 0
		startExtending()
	if Time.get_ticks_msec() > retreatStart && retreatStart != 0:
		retreatStart = 0
		startRetreating()
		
	if extending:
		HAND_POS += HAND_SPEED * delta
		HAND_POS = clamp(HAND_POS,0,HAND_MAX_EXTEND)
		
		var hand:AnimatedSprite2D = $AnimatedSprite2D
		$AnimatedSprite2D.position.y = HAND_ORIGIN - HAND_POS
		if HAND_POS == HAND_MAX_EXTEND:
			extending = false
	
	
	if retreating:
		HAND_POS -= HAND_SPEED_RETREAT * delta
		HAND_POS = clamp(HAND_POS,0,HAND_MAX_EXTEND)
		
		var hand:AnimatedSprite2D = $AnimatedSprite2D
		$AnimatedSprite2D.position.y = HAND_ORIGIN - HAND_POS
		if HAND_POS == 0:
			retreating = false
	
	
	
