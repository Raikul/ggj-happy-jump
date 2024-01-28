extends RigidBody2D

@export var texturas : Array[Texture2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect.texture = texturas.pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
