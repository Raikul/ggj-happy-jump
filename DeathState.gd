class_name DeathState
extends State

signal skeleton_fallen
 
@export var actor: CharacterBody2D
@onready var skeleton_animation = actor.get_node("Visuals/SkeletonAnimation")
var respawn_timer
# Called when the node enters the scene tree for the first time.
func _ready():
	respawn_timer = actor.get_node("RespawnTimer")
	respawn_timer.connect("timeout", respawn)
	pass # Replace with function body.


func Physics_update(_delta):
	#anim.play
	#aca
	skeleton_fallen.emit()
	actor.velocity = Vector2.ZERO
	if respawn_timer.time_left == 0:
		respawn_timer.start(3)
	
func respawn():
	actor.dead = false
	transitioned.emit("IdleWalkState")
	
	
	
