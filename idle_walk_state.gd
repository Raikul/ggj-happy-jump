class_name IdleWalkState
extends State
 
@export var actor: CharacterBody2D

var SPEED = 900
var JUMP_VELOCITY = -1000
 
func Physics_update(_delta):
	if actor.dead:
		print("dead")
		transitioned.emit("DeathState")
	
	var is_jump_just_pressed: bool = Input.is_action_just_pressed("ui_accept")
	
	if is_jump_just_pressed:
		if actor.is_on_floor():
			actor.velocity.y = JUMP_VELOCITY
			transitioned.emit("JumpingState")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		transitioned.emit("WalkingState")
	else:
		$"../../Visuals/SkeletonAnimation".play("idle")
