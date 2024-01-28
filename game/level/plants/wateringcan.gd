extends Area2D

@export var vert_wobble_amount = 50

var start_pos
var _fall = false

func _ready():
	start_pos = transform.origin
	
func _process(delta):
	if not _fall:
		var vert_wobble = sin(Time.get_ticks_msec() / 500.0) * vert_wobble_amount
		position = start_pos + Vector2(0, vert_wobble)
	else:
		($'..' as PathFollow2D).progress_ratio += 0.3 * delta
		if ($'..' as PathFollow2D).progress_ratio >= 1:
			$'../../..'.complete()
			print('complete')
	queue_redraw()

func _on_body_entered(body):
	if body.name == 'Player':
		# body.on_pickup_wateringcan()
		_fall = true
