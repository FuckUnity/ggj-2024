extends level_base

var cursor_paw = load("res://assets/paw.png")
var template_bird = preload("res://level/moorhuhn/bird.tscn")

var bpm = 10.0
var rng = RandomNumberGenerator.new()
var points = 0

var birds = [] as Array[Bird]
var next_bird_spawn_in_s = 0.0
var max_birds = 10
var max_points = 5
var bird_holder: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	bird_holder = get_node('./BirdHolder')
	Input.set_custom_mouse_cursor(cursor_paw, 0, Vector2(64, 64))

func _physics_process(delta):
	next_bird_spawn_in_s = next_bird_spawn_in_s - delta;
	
	if next_bird_spawn_in_s < 0.0 and birds.size() < max_birds:
		next_bird_spawn_in_s = ((1 / bpm) + rng.randf_range(-0.02, 0.02)) * 60.0
		var bird = game.assets.spawn_new(bird_holder, template_bird)
		bird.set_start()
		birds.push_back(bird)
		
	for bird in birds:
		bird.move()
		
	_remove_unused_birds()

func _remove_unused_birds():
	var toDel = []
	
	for bird in birds:
		if bird.state == Bird.State.DELETABLE:
			toDel.push_back(bird)
	
	for bird in toDel:
		birds.erase(bird)
		bird_holder.remove_child(bird)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if points >= max_points:
		complete()
	
func _input(event):
	if !event is InputEventMouseButton:
		return
		
	if event.button_index != MOUSE_BUTTON_LEFT or !event.pressed:
		return
		
	print("Left button was clicked at ", event.position)
			
	var pos = event.position - get_viewport().size * 0.5
	for bird in birds:
		var precision = bird.was_hit(pos)
		if precision > 0:
			bird.killed()
			points += precision
			print("points: ", points)
