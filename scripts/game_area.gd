extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.connect("lost", game_over)
	pass # Replace with function body.
	
func game_over():
	get_tree().quit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

