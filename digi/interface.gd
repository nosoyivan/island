extends Control
@onready var info = $Bar/Info

@onready var textrect = $HUD/TextureRect
@onready var button1 = $Button1/Button
@onready var button2 = $Button2/Button
@onready var button3 = $Button3/Button
@onready var button4 = $Button4/Button

@onready var buttons := [
	button1,
	button2,
	button3,
	button4
]
@onready var daybar = $Bar/DayBar

var day = 0

var mode = "Base"
# Called when the node enters the scene tree for the first time.
func _ready():
	state()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	daybar.value += .05
	pass

func state():
	_disconnect()
	dayChange()
	if mode == "Base":
		button1.text = "Kitchen"
		button1.pressed.connect(_pressKITCHEN)
		button2.text = "Gym"
		button2.pressed.connect(_pressGYM)
		button3.text = "Playground"
		button3.pressed.connect(_pressPLAYGROUND)
		button4.text = "Room"
		button4.pressed.connect(_pressROOM)
	elif mode == "Kitchen":
		button1.text = "Back"
		button1.pressed.connect(_pressBTN)
		button1.modulate = Color(1.0, 0, 0, 1.0)
		button2.text = "Eat"
		button2.pressed.connect(_pressPLAY)
		button3.text = "Prep"
		button3.pressed.connect(_pressTRAIN)
		button4.text = "Test"
		button4.pressed.connect(_pressBATTLE)
	elif mode == "Gym":
		button1.text = "Train"
		button1.pressed.connect(_pressBTN)
		button2.text = "Back"
		button2.pressed.connect(_pressBTN)
		button2.modulate = Color(1.0, 0, 0, 1.0)
		button3.text = "Battle"
		button3.pressed.connect(_pressTRAIN)
		button4.text = "Test"
		button4.pressed.connect(_pressBATTLE)
	elif mode == "Playground":
		button1.text = "Swings"
		button1.pressed.connect(_pressBTN)
		button2.text = "Slide"
		button2.pressed.connect(_pressPLAY)
		button3.text = "Back"
		button3.pressed.connect(_pressBTN)
		button3.modulate = Color(1.0, 0, 0, 1.0)
		button4.text = "Tag"
		button4.pressed.connect(_pressBATTLE)
	elif mode == "Room":
		button1.text = "Sleep"
		button1.pressed.connect(_pressBTN)
		button2.text = "Shower"
		button2.pressed.connect(_pressPLAY)
		button3.text = "Dress"
		button3.pressed.connect(_pressTRAIN)
		button4.text = "Back"
		button4.pressed.connect(_pressBTN)
		button4.modulate = Color(1.0, 0, 0, 1.0)

func _pressBTN():
	mode = "Base"
	state()

func _pressKITCHEN():
	mode = "Kitchen"
	state()

func _pressGYM():
	mode = "Gym"
	state()

func _pressPLAYGROUND():
	mode = "Playground"
	state()

func _pressROOM():
	mode = "Room"
	state()

func _pressPLAY():
	print("Play")
	state()

func _pressTRAIN():
	print("Train")
	state()

func _pressBATTLE():
	print("Battle")
	state()

func _disconnect():
	for btn in buttons:
		for conn in btn.pressed.get_connections():
			btn.pressed.disconnect(conn["callable"])
		btn.modulate = Color(0.35, 0.35, 0.35, 1.0)

func _dayBar(value):
	if value == 100:
		day += 1
		daybar.value = 0
		dayChange()

func dayChange():
	info.text = str("Mode: ",mode," | Day: ",day)
