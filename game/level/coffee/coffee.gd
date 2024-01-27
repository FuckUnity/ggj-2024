extends level_base

var cursor_paw = load("res://assets/tiny_paw.png")
var empty_cup = load("res://level/coffee/icons/coffee_cup_empty.png")
var full_cup = load("res://level/coffee/icons/coffee_cup_full.png")
var full = false
var poaring = false
var clickable = true

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
	Vector2(1062, 667), # 0 -- right edge
	Vector2( 883, 667), # 1
	Vector2( 800, 667), # 2
	Vector2( 720, 667), # 3
	Vector2( 664, 667), # 4 -> goal_pos
	Vector2( 560, 667), # 5
	Vector2( 447, 667), # 6 -- left edge
]
var cur_pos = 0
var goal_pos = 4

var cat_face
var count_cat_faces = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	$CanvasLayer/Control/GridContainer/type_label.text = str(type)
	$CanvasLayer/Control/GridContainer/bean_label.text = str(beans)
	$CanvasLayer/Control/GridContainer/bar_label.text = str(bar)
	$CanvasLayer/Control/display/clock.text = times[cur_time]
	Input.set_custom_mouse_cursor(cursor_paw, 0, Vector2(32, 32))
	#cat_face = $CanvasLayer/Control/coffee_cup/AnimatedSprite2D
	$CanvasLayer/Control/coffee_cup.set_position(cup_positions[cur_pos])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func click_button():
	clickable = false;
	$button.play()

func _on_pour_coffee_button_pressed():
	if full || poaring: return
	poaring = true
	click_button()
	$pouring_coffee.play()
	if cur_pos == goal_pos:
		print("play cup animation")
		$CanvasLayer/Control/PouringCoffee.play("cup")
		return
	$CanvasLayer/Control/PouringCoffee.play("default")


func _on_adjust_bar_button_pressed():
	click_button()
	if bar == 15: bar = 20
	elif bar == 20: bar = 10
	elif bar == 10: bar = 15
	$CanvasLayer/Control/GridContainer/bar_label.text = str(bar)

func _on_adjust_beans_button_pressed():
	click_button()
	beans = (beans % 3) + 1
	$CanvasLayer/Control/GridContainer/bean_label.text = str(beans)

func _on_adjust_type_button_pressed():
	click_button()
	type = (type % 3) + 1
	$CanvasLayer/Control/GridContainer/type_label.text = str(type)


func _on_display_pressed():
	cur_time = (cur_time + 1) % times.size()
	$CanvasLayer/Control/display/clock.text = times[cur_time]


func _on_coffee_cup_pressed():
	cur_pos = (cur_pos + 1) % cup_positions.size()
	if cur_pos == 0:
		#$CanvasLayer/Control/coffee_cup.set_texture_normal(empty_cup)
		#cat_face.frame = (cat_face.frame + 1) % count_cat_faces
		full = false
	$CanvasLayer/Control/coffee_cup.set_position(cup_positions[cur_pos])

func _on_animated_sprite_2d_animation_finished():
	print("finished poaring coffee :P")
	if cur_pos != goal_pos:
		return
	#$CanvasLayer/Control/coffee_cup.set_texture_normal(full_cup)
	# 01:00 PM - 3 be, 10 ba, 1 bt
	if beans == 3 && bar == 10 && type == 1 && times[cur_time] == "01:00 PM":
		$CanvasLayer/Control/speech_bubble/humans_response.text = pos_response
	else: $CanvasLayer/Control/speech_bubble/humans_response.text = neg_response
	$CanvasLayer/Control/speech_bubble.visible = true
	full = true

func _on_speech_bubble_hidden():
	# print("bubble gone")
	if  $CanvasLayer/Control/speech_bubble/humans_response.text != pos_response:
		return
	$"CanvasLayer/Control/winning screen".visible = true
	$winning_purring.autoplay = true
	$winning_purring.play()


func _on_winning_screen_pressed():
	complete()


func _on_pouring_coffee_finished():
	poaring = false


func _on_button_finished():
	clickable = true


func _on_background_finished():
	$background.play()


func _on_winning_purring_finished():
	$winning_purring.play()
