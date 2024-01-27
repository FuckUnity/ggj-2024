class_name WindowGamePoint extends RigidBody2D

var delivered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(1)
	pass # Replace with function body.
	
func set_start(rng: RandomNumberGenerator):
	set_position(Vector2(rng.randf_range(-5, 5), 0))

func _integrate_forces(state: PhysicsDirectBodyState2D):
	if not delivered and state.get_contact_count() > 0:
		set_contact_monitor(false)
		set_max_contacts_reported(0)
		delivered = true
