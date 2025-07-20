extends Control

@onready var zonelabel = $Sidebar/VBoxContainer/ZoneLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func FooterMessage(text):
	zonelabel.text = str("Entering ",text) # Replace with function body.
