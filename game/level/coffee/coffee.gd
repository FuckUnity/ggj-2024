extends level_base

var cursor_paw = load("res://level/coffee/sprites/drawn_paw.png")
var cursor_dark_paw = load("res://level/coffee/sprites/dark_paw.png")
var empty_cup = load("res://level/coffee/icons/coffee_cup_empty.png")
var full_cup = load("res://level/coffee/icons/coffee_cup_full.png")
var button_left = load("res://level/coffee/icons/button_left.png")
var button_down = load("res://level/coffee/icons/button_down.png")
var button_right = load("res://level/coffee/icons/button_right.png")
var pos_response = load("res://level/coffee/sprites/positiv_response.png")
var neg_response = load("res://level/coffee/sprites/negativ_response.png")
var button_dict = {
	1 : button_right,
	2 : button_down,
	3 : button_left
}
var full = false
var poaring = false
var clickable = true

# Initial States
var beans = 2
var bar = 2
var type = 3
var times = ["12:36 PM","12:41 PM","12:59 PM","01:00 PM","01:15 PM"]
var cur_time = 0

var cup_positions = [
	Vector2(1062, 729), # 0 -- right edge
	Vector2( 980, 729), # 1
	Vector2( 800, 729), # 2 -> goal
	Vector2( 720, 729), # 3
	Vector2( 664, 729), # 4
	Vector2( 560, 729), # 5
	Vector2( 447, 729), # 6 -- left edge
]
var cur_pos = 0
var goal_pos = 2

var MAX_VISIBLE = 4.5
var count_visible = 0.0

var bubble


func set_paw():
	Input.set_custom_mouse_cursor(cursor_paw, 0, Vector2(63,63))

func set_dark_paw():
	Input.set_custom_mouse_cursor(cursor_dark_paw, 0, Vector2(63,63))

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	$CanvasLayer/Control/display/clock.text = times[cur_time]
	set_paw()
	bubble = $CanvasLayer/Control/bubble
	$CanvasLayer/Control/coffee_cup.set_position(cup_positions[cur_pos])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if bubble.visible == false: return
	count_visible += delta
	if count_visible < MAX_VISIBLE: return # keep counting
	# hide and reset
	bubble.visible = false 
	count_visible = 0.0


func click_button():
	clickable = false;
	$button.play()

func _on_pour_coffee_button_pressed():
	if full || poaring: return
	poaring = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	click_button()
	$pouring_coffee.play()
	$CanvasLayer/Control/PouringCoffee.play("default")


func _on_adjust_bar_button_pressed():
	click_button()
	bar = (bar % 3) + 1
	print(bar)
	$CanvasLayer/Control/adjust_bar_button.set_texture_normal(button_dict[bar])

func _on_adjust_beans_button_pressed():
	click_button()
	beans = (beans % 3) + 1
	print(beans)
	$CanvasLayer/Control/adjust_beans_button.set_texture_normal(button_dict[beans])

func _on_adjust_type_button_pressed():
	click_button()
	type = (type % 3) + 1
	print(type)
	$CanvasLayer/Control/adjust_type_button.set_texture_normal(button_dict[type])


func _on_display_pressed():
	cur_time = (cur_time + 1) % times.size()
	$CanvasLayer/Control/display/clock.text = times[cur_time]


func _on_coffee_cup_pressed():
	if poaring: return
	$sliding_cup.play()
	cur_pos = (cur_pos + 1) % cup_positions.size()
	if cur_pos == 0:
		$CanvasLayer/Control/coffee_cup/steam.play("none")
		$CanvasLayer/Control/coffee_cup/steam.stop()
		#$CanvasLayer/Control/coffee_cup.set_texture_normal(empty_cup)
		#cat_face.frame = (cat_face.frame + 1) % count_cat_faces
		full = false
	$CanvasLayer/Control/coffee_cup.set_position(cup_positions[cur_pos])

func _on_animated_sprite_2d_animation_finished():
	print("finished poaring coffee :P")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if cur_pos != goal_pos:
		return
	#$CanvasLayer/Control/coffee_cup.set_texture_normal(full_cup)
	$CanvasLayer/Control/coffee_cup/steam.play("default")
	# 01:00 PM - 3 be, 10 ba, 1 bt
	if beans == 3 && bar == 1 && type == 1 && times[cur_time] == "01:00 PM":
		bubble.set_texture(pos_response)
	else: bubble.set_texture(neg_response)
	bubble.visible = true
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

func _on_adjust_type_button_mouse_entered():
	set_dark_paw()

func _on_adjust_type_button_mouse_exited():
	set_paw()

func _on_adjust_beans_button_mouse_entered():
	set_dark_paw()

func _on_adjust_beans_button_mouse_exited():
	set_paw()

func _on_adjust_bar_button_mouse_entered():
	set_dark_paw()

func _on_adjust_bar_button_mouse_exited():
	set_paw()

func _on_pour_coffee_button_mouse_entered():
	set_dark_paw()

func _on_pour_coffee_button_mouse_exited():
	set_paw()

func _on_coffee_cup_mouse_entered():
	set_dark_paw()

func _on_coffee_cup_mouse_exited():
	set_paw()

func _on_display_mouse_entered():
	set_dark_paw()

func _on_display_mouse_exited():
	set_paw()
