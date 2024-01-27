class_name Pickup extends Area2D

@export var pickup_type = PickupType.Boost
@export var vert_wobble_amount = 50

var start_pos
func _ready():
	start_pos = transform.origin
	
func _process(delta):
	var vert_wobble = sin(Time.get_ticks_msec() / 500.0) * vert_wobble_amount
	position = start_pos + Vector2(0, vert_wobble)
	queue_redraw()

func _on_body_entered(body):
	if body.name == 'Player':
		body.on_pickup(self)

enum PickupType{
	Boost,
	Toy
}
