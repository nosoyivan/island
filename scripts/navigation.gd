extends Node2D
signal message(text: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var NT: String = "Base"

func _NT(text):
	message.emit(text)
	Stats.zone = text
	pass
func HealZone(body):
	_NT("Heal")
	pass # Replace with function body.

func ToolZone(body):
	_NT("Tool")
	pass # Replace with function body.


func FoodZone(body):
	_NT("Food")
	pass # Replace with function body.

func FightZone(body):
	_NT("Fight")
	pass # Replace with function body.

func BaseZone(body):
	_NT("Base")
	pass # Replace with function body.
