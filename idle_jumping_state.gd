class_name IdleStateJump
extends State
 
@export var actor: CharacterBody2D

var JUMP_VELOCITY = -1000
 
func Physics_update(_delta):
	var is_jump_just_pressed: bool = Input.is_action_just_pressed("ui_accept")
	
	if is_jump_just_pressed:
		if actor.is_on_floor():
			actor.velocity.y = JUMP_VELOCITY
			transitioned.emit("JumpingState")
