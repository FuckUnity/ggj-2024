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
var tipp_response = load("res://level/coffee/sprites/tipp_response.png")
var pos_olli = load("res://level/coffee/sprites/positiv_olli.png")
var tipp_olli = load("res://level/coffee/sprites/tipp_olli.png")
var neg_olli = load("res://level/coffee/sprites/negativ_olli.png")
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
var cur_time = 0

var cup_positions = [
	Vector2( 509, 615), # 0 -- right edge
	Vector2( 476, 615), # 1
	Vector2( 275, 615), # 2 -> goal
	Vector2( 220, 615), # 3
	Vector2( 160, 615), # 4
	Vector2(  80, 615), # 5
	Vector2( -14, 615), # 6
	Vector2(-119, 838)  # -- left edge
]
var cur_pos = 0
var goal_pos = 2
var won = false

var MAX_VISIBLE = 4.5
var count_visible = 0.0

var TIPP_COUNT = 30
var tipp_timer = 0.0

var FALL_TIME = 1.0
var fall_timer = 0.0
var falling = false

var bubble
var text
var olli
var cup
var steam
var pouring
var clock
var falling_cup
var crash

func set_paw():
	Input.set_custom_mouse_cursor(cursor_paw, 0, Vector2(63,63))

func set_dark_paw():
	Input.set_custom_mouse_cursor(cursor_dark_paw, 0, Vector2(63,63))

func olli_tipp():
	text.set_frame(2)
	olli.set_texture(tipp_olli)
	bubble.visible = true

func olli_positiv():
	text.set_frame(1)
	olli.set_texture(pos_olli)
	bubble.visible = true
	won = true
	
func olli_negativ():
	text.set_frame(3)
	olli.set_texture(neg_olli)
	bubble.visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	set_paw()
	bubble = $CanvasLayer/Control/bubble
	text = $CanvasLayer/Control/bubble/text
	olli = $CanvasLayer/Control/bubble/olli
	cup = $CanvasLayer/Control/machine/coffee_cup
	cup.set_position(cup_positions[cur_pos])
	steam = $CanvasLayer/Control/machine/coffee_cup/steam
	pouring = $CanvasLayer/Control/machine/PouringCoffee
	clock = $CanvasLayer/Control/display/clock
	clock.set_frame(cur_time)
	falling_cup = $CanvasLayer/Control/cup
	crash = $crash

func handle_bubble(delta):
	if bubble.visible == false: return
	count_visible += delta
	if count_visible < MAX_VISIBLE: return # keep counting
	# hide and reset
	bubble.visible = false 
	count_visible = 0.0

func handle_tipp(delta):
	if won: return
	tipp_timer += delta
	if tipp_timer < TIPP_COUNT: return # keep counting
	# as long as a reaction is displayed don't give a tipp
	if bubble.visible: return
	print("bubble invis" + str(tipp_timer))
	olli_tipp()
	tipp_timer = 0.0

func handle_falling(delta):
	if !falling_cup.visible || falling: return
	fall_timer += delta
	if fall_timer < FALL_TIME: return
	falling = true
	crash.play()
	fall_timer = 0.0
	
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_bubble(delta)
	handle_tipp(delta)
	handle_falling(delta)
	

func click_button():
	clickable = false;
	$button.play()

func _on_pour_coffee_button_pressed():
	if full || poaring: return
	poaring = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	click_button()
	$pouring_coffee.play()
	pouring.play("default")


func _on_adjust_bar_button_pressed():
	click_button()
	bar = (bar % 3) + 1
	print(bar)
	$CanvasLayer/Control/machine/adjust_bar_button.set_texture_normal(button_dict[bar])

func _on_adjust_beans_button_pressed():
	click_button()
	beans = (beans % 3) + 1
	print(beans)
	$CanvasLayer/Control/machine/adjust_beans_button.set_texture_normal(button_dict[beans])

func _on_adjust_type_button_pressed():
	click_button()
	type = (type % 3) + 1
	print(type)
	$CanvasLayer/Control/machine/adjust_type_button.set_texture_normal(button_dict[type])


func _on_display_pressed():
	cur_time = (cur_time + 1) % 5
	clock.set_frame(cur_time)


func _on_coffee_cup_pressed():
	if poaring: return
	$sliding_cup.play()
	cur_pos = (cur_pos + 1) % cup_positions.size()
	if cur_pos == cup_positions.size() - 1:
		cup.set_rotation(-76)
	elif cur_pos == 0:
		cup.visible = false
		falling_cup.visible = true
		fall_timer = 0.0
		steam.play("none")
		steam.stop()
		full = false
		falling_cup.set_position(Vector2(432, 929))
		falling_cup.sleeping = false
	cup.set_position(cup_positions[cur_pos])
	
func reset_coffee_cup():
	falling = false
	cup.set_rotation(0)
	cup.visible = true
	falling_cup.visible = false
	falling_cup.sleeping = true

func _on_animated_sprite_2d_animation_finished():
	print("finished poaring coffee :P")
	if !won: Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if cur_pos != goal_pos: return
	steam.play("default")
	# 01:00 PM - 3 be, 10 ba, 1 bt
	if beans == 3 && bar == 1 && type == 1 && cur_time == 3:
		olli_positiv()
	else: olli_negativ()
	full = true

func _on_winning_screen_pressed():
	complete()


func _on_pouring_coffee_finished():
	poaring = false


func _on_button_finished():
	clickable = true

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

func _on_bubble_hidden():
	if !won: return
	$"CanvasLayer/Control/winning screen".visible = true
	$winning_purring.autoplay = true
	$winning_purring.play()
	bubble.set_texture(null)
	bubble.visible = true


func _on_crash_finished():
	reset_coffee_cup()
