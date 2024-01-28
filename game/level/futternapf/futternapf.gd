extends level_base

const dialogTree = [
	{
		'Q': "Are you hungry?",
		'a1': 2,
		'a2': 1,
		'a3': 1
	},
	{
		'Q': "You cant be hungry, I just fed you!",
		'a1': 3,
		'a2': 2,
		'a3': 1
	},
	{
		'Q': "Wann play?",
		'a1': 1,
		'a2': 1,
		'a3': 4
	},
	{
		'Q': "Don't wanna play?",
		'a1': 3,
		'a2': 3,
		'a3': 5
	},
	{
		'Q': "Wanna go outside?",
		'a1': 3,
		'a2': 2,
		'a3': 6
	},
	{
		'Q': "Don't wanna go outside?",
		'a1': 7,
		'a2': 4,
		'a3': 1
	},
	{
		'Q': "Don't wanna go outside,\nDon't wanna play,\nCant help you!",
		'a1': 8,
		'a2': 8,
		'a3': 8
	}
]

var current_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_init_q(1)

func _init_q(nr):
	if nr == 8:
		complete()
		return
	nr -= 1 # index ist 0 based
	current_level = nr
	$contanier/Q.text = dialogTree[nr].Q

func _on_a_1_pressed():
	var next = dialogTree[current_level].a1
	_init_q(next)

func _on_a_2_pressed():
	var next = dialogTree[current_level].a2
	_init_q(next)

func _on_a_3_pressed():
	var next = dialogTree[current_level].a3
	_init_q(next)
