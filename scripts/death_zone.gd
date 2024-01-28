extends Area2D

@export var character : CharacterBody2D

func _on_body_entered(body):
	if body is PersonajePrincipal:
		character.position = GlobalControls.last_sarcofhagus
