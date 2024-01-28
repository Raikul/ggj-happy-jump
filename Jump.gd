class_name JumpingState
extends State
 
@export var actor: CharacterBody2D
@onready var skeleton_animation = actor.get_node("Visuals/SkeletonAnimation")
#var JUMP_VELOCITY = -1000
var SPEED = 900

func Physics_update(_delta):
	if actor.dead:
		transitioned.emit("DeathState")
	skeleton_animation.play("jump")
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		actor.velocity.x = direction * SPEED
	else:
		actor.velocity.x = move_toward(actor.velocity.x, 0, SPEED)
	if actor.is_on_floor():
		skeleton_animation.stop()
		transitioned.emit("IdleWalkState")


