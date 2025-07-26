# CardManager.gd
extends Node
class_name CardManager

# -- 1. RNG for all random ops
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

# -- 2. Our "deck" of cards
var deck: Array = []

# -- 3. (Optional) Character templates to choose from
const TEMPLATES: Array[Dictionary] = [
	{
		"Type": "Character",
		"Name": "Player",
		"Level": 1,
		"HP_range": Vector2i(6,10),    # we'll pick random HP in this range
		"ATK_range": Vector2i(2,5),
		"DEF_range": Vector2i(0,2),
		"Info": {
			"Bio": "Main hero of the story",
			"Attack": "Punch",
			"AttackBio": "A solid closed‑fist strike"
		}
	},
	{
		"Type": "Character",
		"Name": "Rogue",
		"Level": 1,
		"HP_range": Vector2i(4,8),
		"ATK_range": Vector2i(3,6),
		"DEF_range": Vector2i(1,3),
		"Info": {
			"Bio": "A sneaky quick attacker",
			"Attack": "Stab",
			"AttackBio": "Quick dagger thrust"
		}
	},


	{
	  "Type": "Beast",
	  "Name": "Forest Bear",
	  "Level": 2,
	  "HP_range": Vector2i(12,16),
	  "ATK_range": Vector2i(5,8),
	  "DEF_range": Vector2i(2,4),
	  "Info": {
		"Bio": "A fierce woodland creature",
		"Attack": "Swipe",
		"AttackBio": "Powerful claw swipe"
	  }
	}


]

func _ready():
	rng.randomize()
	_generate_deck(20)
	deck.shuffle()   # in‑place shuffle of the Array
	_print_deck()

# Generates `count` cards and adds them to `deck`
func _generate_deck(count: int) -> void:
	for i in count:
		# 1) pick a random template
		var tpl = TEMPLATES[rng.randi_range(0, TEMPLATES.size() - 1)]
		# 2) duplicate it so we don't overwrite the original
		var card = tpl.duplicate(true) as Dictionary
		# 3) assign a random card number between 1 and 20
		card["Num"] = rng.randi_range(1, 20)
		# 4) roll actual stats from the ranges in the template
		card["HP"]  = rng.randi_range(card["HP_range"].x,  card["HP_range"].y)
		card["ATK"] = rng.randi_range(card["ATK_range"].x, card["ATK_range"].y)
		card["DEF"] = rng.randi_range(card["DEF_range"].x, card["DEF_range"].y)
		# 5) we don’t need those temp "_range" fields any more
		card.erase("HP_range")
		card.erase("ATK_range")
		card.erase("DEF_range")
		# 6) add to deck
		deck.append(card)

# Helper to print out the shuffled deck
func _print_deck() -> void:
	for card in deck:
		print( "Card #%d: %s Lvl%d (HP:%d, ATK:%d, DEF:%d)" %
			[ card["Num"], card["Name"], card["Level"],
			  card["HP"], card["ATK"], card["DEF"] ] )
