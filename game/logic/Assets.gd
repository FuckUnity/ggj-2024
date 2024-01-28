class_name Assets extends Object

const template_level_main = preload("res://level/main/main.tscn")
const template_level_window = preload("res://level/moorhuhn/moorhuhn.tscn")
const template_level_cat_tree = preload("res://level/kratzbaum/kratzbaum.tscn")
const template_level_coffee = preload("res://level/coffee/coffee.tscn")
const template_level_computer = preload("res://level/keyboard/keyboard.tscn")
const template_level_food_bowl = preload("res://level/futternapf/futternapf.tscn")
const template_level_plants = preload("res://level/plants/plants.tscn")
const template_level_credits = preload("res://level/credits/credits.tscn")

func spawn_new(on: Node, template: Resource, pos:Vector2 = Vector2()):
	var newInstance = template.instantiate()
	on.add_child(newInstance)
	if !(newInstance is CanvasLayer):
		newInstance.position = pos
	return newInstance

func spawn_level(on: Node, template: Resource):
	var newInstance = template.instantiate()
	on.add_child(newInstance)
	return newInstance
