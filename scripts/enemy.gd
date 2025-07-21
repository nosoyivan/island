extends CharacterBody2D

signal attack(dmg)
signal move(pos)


var HP : int = 10
var ATK : int = 3
var DEF : int = 3
var MANA : int = 5

func _physics_process(delta):
	# Add the gravity.
	pass


func attacked(dmg):
	print(dmg)
	pass # Replace with function body.

func saw(pos):
	print(pos)
	pass # Replace with function body.
