extends Control

@onready var zonelabel = $Sidebar/VBoxContainer/ZoneLabel

@onready var sub_viewport = $View/SubViewportContainer/SubViewport
@onready var grass = $View/SubViewportContainer/SubViewport/Grass
@onready var navigation = $View/SubViewportContainer/SubViewport/Navigation

@onready var HPLable = $Footer/Stats/Main/Stats/HP
@onready var ATKLable = $Footer/Stats/Main/Stats/ATK
@onready var DEFLable = $Footer/Stats/Main/Stats/DEF
@onready var MANALable = $Footer/Stats/Main/Stats/MANA

@onready var HPEnemy = $Footer/Stats/Enemy/Stats/HP
@onready var ATKEnemy = $Footer/Stats/Enemy/Stats/ATK
@onready var DEFEnemy = $Footer/Stats/Enemy/Stats/DEF
@onready var MANAEnemy = $Footer/Stats/Enemy/Stats/MANA

@onready var info = $Footer/Stats/Info
@onready var enemyStats = $Footer/Stats/Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	_updateUI()

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

func _battleStart():
	info.show()
	enemyStats.show()
	pass

func _battleEnd():
	info.hide()
	enemyStats.hide()
	pass

func _updateUI():
	HPLable.text = str("HP: ",Stats.HP)
	ATKLable.text = str("ATK: ",Stats.ATK)
	DEFLable.text = str("DEF: ",Stats.DEF)
	MANALable.text = str("MANA: ",Stats.MANA)
