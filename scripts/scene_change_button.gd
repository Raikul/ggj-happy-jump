extends Button

@export var scene_to_change : PackedScene

func _on_button_down():
	get_tree().change_scene_to_packed(scene_to_change)
