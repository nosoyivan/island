extends Node2D
# This is the root node for your world/navigation controller.

# ——————————————————————————————————————————————
#  S I G N A L S
# ——————————————————————————————————————————————

signal message(text: String)    # Emit when the player enters a new “zone” type (Heal, Tool, etc.)
signal swap(scene: String)      # Emit when you want to swap scenes/UI (not used in this snippet)
signal battleStart              # Emit at the beginning of a battle (placeholder)
signal battleEnd                # Emit at the end of a battle (placeholder)

# ——————————————————————————————————————————————
#  O N R E A D Y   N O D E   R E F E R E N C E S
# ——————————————————————————————————————————————

@onready var p: CharacterBody2D         = $Character
#   ↑ The player CharacterBody2D node, so we can teleport & stop it.

@onready var path: NavigationRegion2D   = $Path
#   ↑ The NavigationRegion2D whose polygon we swap when changing zones.

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
#   ↑ (Unused here) In case you drive the player via a NavigationAgent.

# ——————————————————————————————————————————————
#  P R E L O A D E D   N A V   P O L Y G O N S
# ——————————————————————————————————————————————

const HOME_PATH  = preload("res://assets/paths/HomePath.tres")
const HEAL_PATH  = preload("res://assets/paths/HealPath.tres")
const GRASS_PATH = preload("res://assets/paths/GrassPath.tres")
const CAVE_PATH  = preload("res://assets/paths/CavePath.tres")
#   ↑ Each of these defines the walkable area for that zone.

# ——————————————————————————————————————————————
#  S C E N E – P A C K A G E S   ( U N I N S T A N C E D )
# ——————————————————————————————————————————————

var ZonesScene       := preload("res://scenes/maps/zones.tscn")
var GrassZonesScene  := preload("res://scenes/maps/grasszones.tscn")
var CaveZonesScene   := preload("res://scenes/maps/cavezones.tscn")
var HealZoneScene    := preload("res://Scenes/maps/zones/heal.tscn")
#   ↑ These hold the PackedScene references; we call `.instantiate()` when we need them.

# ——————————————————————————————————————————————
#  C U R R E N T   Z O N E   I N S T A N C E
# ——————————————————————————————————————————————

var current_zone: Node = null
#   ↑ Will point to whichever zone node is active in the scene tree.

# ——————————————————————————————————————————————
#  _ready():  I N I T I A L   S E T U P
# ——————————————————————————————————————————————

func _ready() -> void:

	# On startup, go straight to the Home zone.
	_go_to_home()

# ——————————————————————————————————————————————
#  Z O N E   M A N A G E M E N T   F U N C T I O N S
# ——————————————————————————————————————————————

func _clear_zone() -> void:
	# If there’s already a zone in the tree, free it before loading a new one:
	if current_zone and is_instance_valid(current_zone):
		current_zone.queue_free()
		current_zone = null

func _go_to_home() -> void:
	# 1) Teleport player to home start position:
	var pos
	if Stats.zone == "Base":
		pos = Vector2(379, 301)
	elif Stats.zone == "Grass":
		pos = Vector2(379.0, 100)
	elif Stats.zone == "Heal":
		pos = Vector2(270, 480)
	Stats.zone = "Base"
	#_NT("Base")
	_hidezone(pos)
	# 2) Free any old zone:
	_clear_zone()
	# 3) Instantiate & add the Home “Zones” scene:
	current_zone = ZonesScene.instantiate()
	add_child(current_zone)
	# 4) Wire up all the Area2D signals in it:
	_connect_areas(current_zone)
	# 5) Swap the NavigationRegion’s polygon:
	path.navigation_polygon = HOME_PATH

func _go_to_grass() -> void:
	var pos
	if Stats.zone == "Base":
		pos = Vector2(570, 570)
	elif Stats.zone == "Cave":
		pos = Vector2(600, 270)
	Stats.zone = "Grass"
	#_NT("Grass")

	_hidezone(pos)
	_clear_zone()
	current_zone = GrassZonesScene.instantiate()
	add_child(current_zone)
	_connect_areas(current_zone)
	path.navigation_polygon = GRASS_PATH

func _go_to_cave() -> void:
	var pos = Vector2(317, 204)
	Stats.zone = "Cave"
	#_NT("Cave")
	_hidezone(pos)
	_clear_zone()
	current_zone = CaveZonesScene.instantiate()
	add_child(current_zone)
	_connect_areas(current_zone)
	path.navigation_polygon = CAVE_PATH


func _go_to_heal() -> void:
	var pos = Vector2(560, 245)
	Stats.zone = "Heal"
	_hidezone(pos)
	_clear_zone()
	current_zone = HealZoneScene.instantiate()
	add_child(current_zone)
	_connect_areas(current_zone)
	path.navigation_polygon = HEAL_PATH
	p.scale = Vector2(3,3)
	
func _connect_areas(zone_node: Node) -> void:
	# Finds every Area2D child of the newly added zone, turns on monitoring,
	# and connects its body_entered to the appropriate callback.
	for child in zone_node.get_children():
		if child is Area2D:
			child.monitoring = true
			# Build a method name like “Home2GrassZone” from the Area2D’s name:
			var method_name = "%sZone" % child.name
			child.body_entered.connect(Callable(self, method_name))

# ——————————————————————————————————————————————
#  Z O N E   C A L L B A C K S
# ——————————————————————————————————————————————

func Home2GrassZone(body) -> void:
	# Player stepped into the Home→Grass portal:
	_go_to_grass()

func Grass2HomeZone(body) -> void:
	_go_to_home()

func Grass2CaveZone(body) -> void:
	_go_to_cave()

func Cave2GrassZone(body) -> void:
	_go_to_grass()

# These other callbacks all follow the same pattern:
func HealZone(body) -> void:
	_NT("Heal")
	_go_to_heal()
	# (insert heal logic here)

func Heal2HomeZone(body) -> void:
	_go_to_home()

func ToolZone(body):
	_NT("Tool")
	# (insert tool logic here)

func FoodZone(body):
	_NT("Food")
	# (insert food logic here)

func FightZone(body):
	_NT("Fight")
	# (insert battle logic here)

func BaseZone(body):
	_NT("Base")
	# (insert base-zone logic here)

# ——————————————————————————————————————————————
#  H E L P E R S  &  I N P U T
# ——————————————————————————————————————————————

func _hidezone(pos: Vector2) -> void:
	# Immediately teleport and halt the player when changing zones
	p.global_position = pos
	p.stop(pos)
	p.scale = Vector2(2,2)
	

func _input(event) -> void:
	# Debug: print the player’s current position if Esc is pressed
	if event.is_action_pressed("Esc"):
		print(p.global_position)

# Emit the “message” signal and update Stats.zone:
var NT: String = "Base"
func _NT(text):
	message.emit(text)
	Stats.zone = text

# Emit the “swap” signal (for UI/scene swaps, not used above):
var SS: String = "Base"
func _SS(scene):
	swap.emit(scene)

# Battle start/end emitters (placeholders):
func _battleStart(dmg):
	battleStart.emit()

func _battleEnd(dmg):
	battleEnd.emit()
