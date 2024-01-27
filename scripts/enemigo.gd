extends CharacterBody2D


const SPEED = 180.0
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_node

func _ready():
	add_to_group("Enemy")
	pass

func _physics_process(delta):
	player_node = get_tree().get_first_node_in_group("Player")
	if player_node != null:
		velocity = position.direction_to(player_node.position) * SPEED
		move_and_slide()
	
	var last_collision = get_last_slide_collision()
	
	if last_collision:
		if last_collision.get_collider().is_in_group("Player"): disappear()

func disappear():
	queue_free()
