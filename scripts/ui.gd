extends Control

@onready var zonelabel = $Sidebar/VBoxContainer/ZoneLabel

@onready var sub_viewport = $View/SubViewportContainer/SubViewport
@onready var grass = $View/SubViewportContainer/SubViewport/Grass
@onready var navigation = $View/SubViewportContainer/SubViewport/Navigation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func FooterMessage(text):
	zonelabel.text = str("Entering ",text) # Replace with function body.


func Swap(scene):
	if scene == "Grass":
		grass.show()
		navigation.hide()
		print("touch")
		pass
	pass # Replace with function body.
