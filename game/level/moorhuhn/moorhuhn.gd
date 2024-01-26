extends level_base

var cursor_paw = load("res://assets/paw.png")
var template_bird = preload("res://level/moorhuhn/bird.tscn")

var bpm = 10.0
var rng = RandomNumberGenerator.new()

var birds = [] as Array[Bird]
var next_bird_spawn_in_s = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	Input.set_custom_mouse_cursor(cursor_paw, 0, Vector2(64, 64))

func _physics_process(delta):
	next_bird_spawn_in_s = next_bird_spawn_in_s - delta;
	
	if next_bird_spawn_in_s < 0.0:
		next_bird_spawn_in_s = ((1 / bpm) + rng.randf_range(-0.02, 0.02)) * 60.0
		var bird = game.assets.spawn_new(self.get_node('./BirdHolder'), template_bird)
		bird.set_start()
		birds.push_back(bird)
		
	for bird in birds:
		bird.move()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	
	
	
	pass
