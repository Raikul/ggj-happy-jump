extends CharacterBody2D
class_name PersonajePrincipal

@export var progressive_frames : Array[SpriteFrames]
const SPEED = 1000.0
const JUMP_VELOCITY = -900.0
const CRASH_VELOCITY = 1200
var bones_left = 4
signal lost
var dead = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var crashing = false


func _ready():
	GlobalControls.last_sarcofhagus = position
	add_to_group("Player")
	#$Visuals/SkeletonAnimation.sprite_frames = progressive_frames[3]



func _physics_process(delta):
	# Add the gravity.

	if not is_on_floor():
		velocity.y += gravity * delta

	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	if velocity.y > CRASH_VELOCITY:
		crashing = true
	else: crashing = false

	move_and_slide()
	var last_collision = get_last_slide_collision()
	
	if last_collision:
		
		if crashing and !is_on_wall() and is_on_floor():
			crash()
		if last_collision.get_collider().is_in_group("Enemy"): 
			get_ghosted()
		if last_collision.get_collider().is_in_group("Quini6"):
			get_tree().change_scene_to_file("res://win.tscn")

func get_ghosted():
	modulate = Color.GREEN_YELLOW
	collapse()

func crash():
	#modulate = Color.RED
	collapse()

func collapse():
	timed_respawn(3)
	Audio.get_node("EsqueletoDesarma").play()
	bones_left -= 1
	if bones_left == 0:
		emit_signal("lost")
		
		get_tree().change_scene_to_file("res://game_over.tscn")

func timed_respawn(time):
	dead = true

func respawn():
	Audio.get_node("EsqueletoArma").play()
	modulate = Color.WHITE


func _on_death_state_skeleton_fallen():
	velocity.x = 0
	$Visuals/Smoke.show()
	$Visuals/SkeletonAnimation.hide()
	await get_tree().create_timer(1).timeout
	$Visuals/Smoke.hide()
	$Visuals/Desarmado.show()
	await get_tree().create_timer(1).timeout
	$Visuals/Smoke.show()
	$Visuals/Desarmado.hide()
	await get_tree().create_timer(1).timeout
	$Visuals/SkeletonAnimation.sprite_frames = progressive_frames[(bones_left - 4) * -1]
	$Visuals/SkeletonAnimation.show()
	$Visuals/Smoke.hide()
	
