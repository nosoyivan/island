extends Node2D

signal message(text: String)
signal swap(scene: String)
@onready var zones = $Zones
@onready var grasszones = $GrassZones
@onready var p = $Character

@export_flags("Home:1", "ome:2", "Grass:4", "Cave:5") var Area
# Called when the node enters the scene tree for the first time.
func _ready():
	match Area:
		1: 
			grasszones.hide()
			p.position = Vector2(379.0, 301.0)

		4: 
			grasszones.hide()
			p.position = Vector2(634.0, 606.0)

func _process(delta):
	print(p.position)
var NT: String = "Base"

func _NT(text):
	message.emit(text)
	Stats.zone = text
	pass

var SS: String = "Base"

func _SS(scene):
	swap.emit(scene)
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

func Home2GrassZone(body):
	#swap.emit("Grass") # Replace with function body.
	grasszones.show()
	zones.hide()
	p.position = Vector2(379.0, 301.0)
