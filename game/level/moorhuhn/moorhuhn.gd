extends level_base

var cursor_paw = load("res://assets/paw.png")
var template_bird = preload("res://level/moorhuhn/bird.tscn")
var template_point = preload("res://level/moorhuhn/point.tscn")
const plant_sad = preload("res://assets/Plants_sad.png")
const plant_happy = preload("res://assets/Plants_happy.png")

var bpm = 20.0
var rng = RandomNumberGenerator.new()

var birds = [] as Array[Bird]
var _point_objects = [] as Array[WindowGamePoint]
var max_birds = 10
var max_points = 10
var bird_holder: Node
var points_holder: Node

var _points_to_spawn = 0

var _next_point_spanw_in_s = 0
var _next_bird_spawn_in_s = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	bird_holder = $"./BirdHolder"
	points_holder = $"./PointsHolder"
	Input.set_custom_mouse_cursor(cursor_paw, 0, Vector2(64, 64))
	
	$"Control3/AspectRatioContainer/TextureRectPlant".set_texture(_get_plants_image())

func _physics_process(delta):
	_next_bird_spawn_in_s = _next_bird_spawn_in_s - delta
	_next_point_spanw_in_s = _next_point_spanw_in_s - delta
	
	_handle_birds()
	_spawn_point()
	_handle_game_end()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _input(event):
	if !event is InputEventMouseButton:
		return
		
	if event.button_index != MOUSE_BUTTON_LEFT or !event.pressed:
		return
			
	$"AudioStreamClick".play()
	var pos = get_viewport().get_camera_2d().get_local_mouse_position()
	
	for bird in birds:
		var precision = bird.was_hit(pos)
		if precision > 0:
			bird.killed()
			_add_points(precision)

func _handle_game_end():
	var delivered_points = _point_objects;
	delivered_points.filter(func(p): p.delivered);
	if delivered_points.size() >= max_points:
		complete()

func _handle_birds():
	if _next_bird_spawn_in_s < 0.0 and birds.size() < max_birds:
		_next_bird_spawn_in_s = ((1 / bpm) + rng.randf_range(-0.02, 0.02)) * 60.0
		var bird = game.assets.spawn_new(bird_holder, template_bird)
		bird.set_start(rng)
		birds.push_back(bird)
		
	_remove_unused_birds()

func _remove_unused_birds():
	var toDel = []
	
	for bird in birds:
		if bird.state == Bird.State.DELETABLE:
			toDel.push_back(bird)
	
	for bird in toDel:
		birds.erase(bird)
		bird_holder.remove_child(bird)

func _add_points(points: int):
	_points_to_spawn += points

func _spawn_point():
	if _points_to_spawn == 0:
		return
		
	if _next_point_spanw_in_s > 0:
		return
		
	var point = game.assets.spawn_new(points_holder, template_point)
	point.set_start(rng)
	_point_objects.push_back(point)
	_next_point_spanw_in_s = rng.randf_range(0.4, 0.7)
	_points_to_spawn -= 1
	
func _get_plants_image():
	if not game or not game.state:
		return null
	match game.state.mainState[MainState.MainSceneObjects.PLANTS]:
		"sad":
			return plant_sad
		"happy":
			return plant_happy
	return null
