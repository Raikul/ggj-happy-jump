extends CharacterBody2D


const SPEED = 180.0
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_node

func _ready():
	add_to_group("Enemy")
	pass
	#player_node = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#move_and_slide()
	player_node = get_tree().get_first_node_in_group("Player")
	if player_node != null:
		velocity = position.direction_to(player_node.position) * SPEED
		move_and_slide()

