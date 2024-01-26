extends Node

var beans = 2
var bar = 15
var type = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Control/type_label.text = str(type)
	$CanvasLayer/Control/bean_label.text = str(beans)
	$CanvasLayer/Control/bar_label.text = str(bar)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pour_coffee_button_pressed():
	# 13:00 AM - 3 be, 10 ba, 1 bt
	print("be: " + str(beans) + ", bar: " + str(bar) + ", type: " + str(type))
	if beans == 3 && bar == 10 && type == 1:
		$CanvasLayer/Control/humans_response.visible = true
		return
	$CanvasLayer/Control/humans_negative_response.visible = true
	

func _on_adjust_bar_button_pressed():
	if bar == 15: bar = 20
	elif bar == 20: bar = 10
	elif bar == 10: bar = 15
	$CanvasLayer/Control/bar_label.text = str(bar)

func _on_adjust_beans_button_pressed():
	print(beans % 3)
	beans = (beans % 3) + 1
	$CanvasLayer/Control/bean_label.text = str(beans)

func _on_adjust_type_button_pressed():
	type = (type % 3) + 1
	$CanvasLayer/Control/type_label.text = str(type)
