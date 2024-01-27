extends CharacterBody2D


const SPEED = 1000.0
const JUMP_VELOCITY = -900.0
const CRASH_VELOCITY = 1200

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var crashing = false
@onready var respawn_timer = $RespawnTimer

func _ready():
	add_to_group("Player")
	respawn_timer.connect("timeout", respawn)

func _physics_process(delta):
	# Add the gravity.

	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if velocity.y > CRASH_VELOCITY:
		crashing = true
	else: crashing = false
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	var last_collision = get_last_slide_collision()
	
	if last_collision:
		if crashing:
			crash()
		if last_collision.get_collider().is_in_group("Enemy"): die()

func die():
	modulate = Color.GREEN_YELLOW
	timed_respawn(3)

func crash():
	modulate = Color.RED
	timed_respawn(3)

func timed_respawn(time):
	respawn_timer.start(time)

	
func respawn():
	modulate = Color.WHITE
