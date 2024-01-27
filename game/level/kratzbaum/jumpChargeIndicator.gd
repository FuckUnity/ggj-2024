extends Node2D

var charge_amount = 0
var flipped = false

@export var size: float = 100

@export var border_size: float = 80
@export var border_offset: float = 5

func draw_circle_outline(draw_radius: float, draw_color: Color, draw_size: float, progress: float = 1):
	var offset = -0.25 * TAU
	draw_arc(Vector2((transform.origin.x * -2 - radius / 2) / transform.get_scale().x, 0) if flipped else Vector2(), draw_radius + draw_size, offset, offset + TAU * progress, 50, draw_color, draw_size / 2, true)

func _process(_delta):
	queue_redraw()
	
func _draw():
	draw_circle_outline(radius + border_offset, Color(1,0,0,1), border_size, charge_amount)

var radius: float

func _ready():
	radius = size * 0.5

func is_position_inside(pos: Vector2) -> bool:
	return position.distance_to(pos) < radius
