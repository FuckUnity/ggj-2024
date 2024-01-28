extends TextureRect

var MAX_VISIBLE = 4.5
var count_visible = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.visible == true:
		count_visible += delta
		if count_visible >= MAX_VISIBLE:
			self.visible = false
			count_visible = 0.0
