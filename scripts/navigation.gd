extends Node2D

signal message(text: String)
signal swap(scene: String)
signal battleStart
signal battleEnd

@onready var zones = $Zones
@onready var grasszones = $GrassZones
@onready var cavezones = $CaveZones

@onready var p = $Character
@onready var path = $Path
@onready var ray = $Ray

const GRASS_PATH = preload("res://assets/paths/GrassPath.tres")
const HOME_PATH = preload("res://assets/paths/HomePath.tres")
const CAVE_PATH = preload("res://assets/paths/CavePath.tres")

var CAVEZONES = preload("res://scenes/maps/cavezones.tscn").instantiate()
var GRASSZONES = preload("res://scenes/maps/grasszones.tscn").instantiate()
var ZONES = preload("res://scenes/maps/zones.tscn").instantiate()


@export_flags("Home:1", "ome:2", "Grass:4", "Cave:5") var Area
# Called when the node enters the scene tree for the first time.

func _ready():
	match Area:
		1: 
			var pos = Vector2(379.0, 301.0)
			_hidezone(pos)
			add_child(ZONES)
			#zones.show()
			path.navigation_polygon = HOME_PATH
		4: 
			#grasszones.hide()
			p.position = Vector2(634.0, 606.0)
			path.navigation_polygon = GRASS_PATH

func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("Esc"):
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
	print("Home2GrassZone")
	var pos = Vector2(570, 570)
	_hidezone(pos)
	ZONES.queue_free()
	path.navigation_polygon = GRASS_PATH


func Grass2HomeZone(body):
	var pos = Vector2(420, 95)
	_hidezone(pos)
	zones.show()
	path.navigation_polygon = HOME_PATH

func Grass2CaveZone(body):
	var pos = Vector2(317, 204)
	_hidezone(pos)
	cavezones.show()
	path.navigation_polygon = CAVE_PATH

func Cave2GrassZone(body):
	var pos = Vector2(607, 274)
	_hidezone(pos)
	grasszones.show()
	path.navigation_polygon = GRASS_PATH

func _hidezone(pos):
	p.position = pos
	p.stop(pos)
	#zones.hide()
	#grasszones.hide()
	#cavezones.hide()


func _battleStart(dmg):
	battleStart.emit()

func _battleEnd(dmg):
	battleEnd.emit()
