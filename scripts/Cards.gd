extends Node

# Declare a variable to hold the full deck of cards.
# Each card will be a Dictionary, and the entire deck is stored in an Array.
var deck: Array[Dictionary] = []

# Create a random number generator instance.
# This gives us better random control than the global randi().
var rng := RandomNumberGenerator.new()


func _ready() -> void:
	# This function runs once when the node enters the scene tree.

	# Seed the random number generator so results differ each time you run the game.
	rng.randomize()

	# Call a function to generate the full shuffled deck of 20 cards.
	deck = build_deck()

	# Print out the full deck for testing/debugging.
	print_deck()

func build_deck() -> Array[Dictionary]:
	# This function builds a shuffled deck of 20 unique cards.

	# Create a list of numbers from 1 to 20 (inclusive).
	var numbers := range(1, 21)

	# Shuffle the numbers to make sure the cards come out in random order.
	numbers.shuffle()

	# Prepare an empty array to hold the final deck of card dictionaries.
	var d: Array[Dictionary] = []

	# For each number in the shuffled list, create a card and add it to the deck.
	for n in numbers:
		d.append(make_card(n))

	# Return the completed randomized deck.
	return d

func make_card(num: int) -> Dictionary:
	# This function returns a new card dictionary using the given unique card number.

	return {
		"Num": num,  # Unique card number (from 1 to 20)
		"Type": "Character",  # Card type (could also be "Spell", "Item", etc.)
		"Name": "Player",  # Default name (can customize later)
		"Level": 1,        # Starting level
		"HP": 8,           # Hit Points
		"ATK": 3,          # Attack stat
		"DEF": 1,          # Defense stat

		# Extra info stored in a nested dictionary.
		"Info": {
			"Bio": "This is the main character",  # Backstory / flavor text
			"Attack": "Punch",                   # Attack name
			"AttackBio": "Closed Fist attack",   # Attack description
		}
	}

func print_deck() -> void:
	# Debug function that prints out the entire deck in order.

	for c in deck:
		# Print each card's number and the full dictionary info.
		print("Card #", c["Num"], " -> ", c)
