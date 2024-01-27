extends level_base

var cursor_paw = load("res://assets/tiny_paw.png")
var empty_cup = load("res://level/coffee/icons/coffee_cup_empty.png")
var full_cup = load("res://level/coffee/icons/coffee_cup_full.png")
var full = false

# Initial States
var beans = 2
var bar = 15
var type = 3
var times = ["12:36 PM","12:41 PM","12:59 PM","01:00 PM","01:15 PM"]
var cur_time = 0
var pos_response = """  Oh thank you!
That's exactly how I like my coffee!!
	*lol*"""
var neg_response = """No that's not the right time for this coffee.
	:-("""
var cup_positions = [
	Vector2(1470, 457),
	Vector2(1000, 457),
	Vector2( 800, 457),
	Vector2( 650, 457),
	Vector2( 470, 457), # goal_pos
	Vector2( 250, 457),
	Vector2(-100, 457),
]
var cur_pos = 0
var goal_pos = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	$CanvasLayer/Control/GridContainer/type_label.text = str(type)
	$CanvasLayer/Control/GridContainer/bean_label.text = str(beans)
	$CanvasLayer/Control/GridContainer/bar_label.text = str(bar)
	$CanvasLayer/Control/display/clock.text = times[cur_time]
	Input.set_custom_mouse_cursor(cursor_paw, 0, Vector2(32, 32))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pour_coffee_button_pressed():
	# 13:00 AM - 3 be, 10 ba, 1 bt
	#print("be: " + str(beans) + ", bar: " + str(bar) + 
		#", type: " + str(type) + ", time: " + times[cur_time] +
		#", cup pos: " + str(cur_pos))
	# animate pouring
	if cur_pos == goal_pos:
		print("play cup animation")
		$AnimatedSprite2D.play("cup")
		return
	$AnimatedSprite2D.play("default")


func _on_adjust_bar_button_pressed():
	if bar == 15: bar = 20
	elif bar == 20: bar = 10
	elif bar == 10: bar = 15
	$CanvasLayer/Control/GridContainer/bar_label.text = str(bar)

func _on_adjust_beans_button_pressed():
	print(beans % 3)
	beans = (beans % 3) + 1
	$CanvasLayer/Control/GridContainer/bean_label.text = str(beans)

func _on_adjust_type_button_pressed():
	type = (type % 3) + 1
	$CanvasLayer/Control/GridContainer/type_label.text = str(type)


func _on_display_pressed():
	cur_time = (cur_time + 1) % times.size()
	$CanvasLayer/Control/display/clock.text = times[cur_time]


func _on_coffee_cup_pressed():
	cur_pos = (cur_pos + 1) % cup_positions.size()
	if cur_pos == 0:
		$CanvasLayer/Control/coffee_cup.set_texture_normal(empty_cup)
	$CanvasLayer/Control/coffee_cup.set_position(cup_positions[cur_pos])

func _on_animated_sprite_2d_animation_finished():
	print("finished poaring coffee :P")
	if cur_pos != goal_pos:
		return
	$CanvasLayer/Control/coffee_cup.set_texture_normal(full_cup)
	if beans == 3 && bar == 10 && type == 1 && times[cur_time] == "01:00 PM":
		$CanvasLayer/Control/speech_bubble/humans_response.text = pos_response
	else: $CanvasLayer/Control/speech_bubble/humans_response.text = neg_response
	$CanvasLayer/Control/speech_bubble.visible = true

func _on_speech_bubble_hidden():
	# print("bubble gone")
	if  $CanvasLayer/Control/speech_bubble/humans_response.text == pos_response:
		$"CanvasLayer/Control/winning screen".visible = true


func _on_winning_screen_pressed():
	complete()
