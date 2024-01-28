class_name WalkingState
extends State
 
@export var actor: CharacterBody2D

var SPEED = 900
var JUMP_VELOCITY = -1000
@onready var skeleton_animation : AnimatedSprite2D = $"../../SkeletonAnimation"
func Physics_update(_delta):
	if actor.dead:
		transitioned.emit("DeathState")
	else:
		
		var is_jump_just_pressed: bool = Input.is_action_just_pressed("ui_accept")
		
		if is_jump_just_pressed:
			if actor.is_on_floor():
				actor.velocity.y = JUMP_VELOCITY
				transitioned.emit("JumpingState")
		#var is_jump_just_pressed: bool = Input.is_action_just_pressed("ui_accept")
		skeleton_animation.play("walk")
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			actor.velocity.x = direction * SPEED
		else:
			actor.velocity.x = move_toward(actor.velocity.x, 0, SPEED)
			skeleton_animation.stop()
			transitioned.emit("IdleWalkState")
	
