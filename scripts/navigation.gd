extends Node2D

signal message(text: String)
signal swap(scene: String)
signal battleStart
signal battleEnd

@onready var CAVEZONES = preload("res://scenes/maps/cavezones.tscn").instantiate()
@onready var GRASSZONES = preload("res://scenes/maps/grasszones.tscn").instantiate()
@onready var ZONES = preload("res://scenes/maps/zones.tscn").instantiate()
@onready var p = $Character
@onready var path = $Path
@onready var ray = $Ray

const GRASS_PATH = preload("res://assets/paths/GrassPath.tres")
const HOME_PATH = preload("res://assets/paths/HomePath.tres")
const CAVE_PATH = preload("res://assets/paths/CavePath.tres")

@onready var Home2Grass: Area2D = $Zones/Home2Grass

@export_flags("Home:1", "ome:2", "Grass:4", "Cave:5") var Area
# Called when the node enters the scene tree for the first time.

func _ready():
	match Area:
		1: 
			var pos = Vector2(379.0, 301.0)
			_hidezone(pos)
			addZone()
			#zones.show()
			path.navigation_polygon = HOME_PATH
		4: 
			add_child(GRASSZONES)
			#grasszones.hide()
			p.position = Vector2(634.0, 606.0)
			path.navigation_polygon = GRASS_PATH

func addZone():
			ZONES = preload("res://scenes/maps/zones.tscn").instantiate()
			add_child(ZONES)
			for child in ZONES.get_children():
				if child is Area2D:
					child.monitoring = true
					child.body_exited.connect(Callable(self, "BaseZone"))
			var home2grass = ZONES.get_node("Home2Grass") as Area2D
			home2grass.body_entered.connect(Callable(self, "Home2GrassZone"))

			var Heal = ZONES.get_node("Heal") as Area2D
			Heal.body_entered.connect(Callable(self, "HealZone"))

			var Tools = ZONES.get_node("Tools") as Area2D
			Tools.body_entered.connect(Callable(self, "ToolsZone"))

			var Food = ZONES.get_node("Food") as Area2D
			Food.body_entered.connect(Callable(self, "FoodZone"))

			var Fight = ZONES.get_node("Fight") as Area2D
			Fight.body_entered.connect(Callable(self, "FightZone"))

func addGRASSZone():
			var GRASSZONES = preload("res://scenes/maps/grasszones.tscn").instantiate()
			add_child(GRASSZONES)
			var Grass2Cave = GRASSZONES.get_node("Grass2Cave") as Area2D
			Grass2Cave.monitoring = true    # ensure it’s monitoring bodies
			Grass2Cave.body_entered.connect(Callable(self, "Grass2CaveZone"))
			var Grass2Home = GRASSZONES.get_node("Grass2Home") as Area2D
			Grass2Home.monitoring = true    # ensure it’s monitoring bodies
			Grass2Home.body_entered.connect(Callable(self, "Grass2HomeZone"))

func addCAVEZone():
			add_child(CAVEZONES)
			var Cave2Grass = CAVEZONES.get_node("Cave2GrassZone") as Area2D
			Cave2Grass.monitoring = true    # ensure it’s monitoring bodies
			Cave2Grass.body_entered.connect(Callable(self, "Cave2GrassZone"))

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
	addGRASSZone()
	#grasszones.show()
	path.navigation_polygon = GRASS_PATH

func Grass2HomeZone(body):
	var pos = Vector2(379.0, 100)
	_hidezone(pos)
	addZone()
	#zones.show()
	path.navigation_polygon = HOME_PATH

func Grass2CaveZone(body):
	var pos = Vector2(317, 204)
	_hidezone(pos)
	GRASSZONES.queue_free()
	addCAVEZone()
	#cavezones.show()
	path.navigation_polygon = CAVE_PATH

func Cave2GrassZone(body):
	var pos = Vector2(600, 270)
	_hidezone(pos)
	CAVEZONES.queue_free()
	addGRASSZone()
	#grasszones.show()
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
