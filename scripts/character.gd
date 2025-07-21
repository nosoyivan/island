extends CharacterBody2D

signal attack(dmg)
signal move(pos)

var movement_speed := 200.0

@onready var ray = $Ray

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 2.0
	navigation_agent.target_desired_distance = 2.0
	navigation_agent.debug_enabled = true

# The "click" event is a custom input action defined in
# Project > Project Settings > Input Map tab.
func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("LMB"):
		return

	set_movement_target(get_global_mouse_position())

func stop(area):
	set_movement_target(area)
	print("Stop")

func _input(event):
	if event.is_action_pressed("RMB"):
		pass


func set_movement_target(movement_target: Vector2) -> void:
	navigation_agent.target_position = movement_target


func _physics_process(_delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()


func contact(body):
	if body.is_in_group("Enemy"):
		attack.emit(Stats.ATK)
		move.emit(position)
		pass
