extends Control

func _process(delta):
	if Input.is_action_just_pressed("fire") or Input.is_action_just_pressed("VR_RIGHT_INDEX_TRIGGER") or Input.is_action_just_pressed("VR_LEFT_INDEX_TRIGGER") or Input.is_action_just_pressed("VR_SCREEN_TAP"):
		get_tree().change_scene("res://Game.tscn")
	elif Input.is_key_pressed(KEY_A):
		get_tree().change_scene("res://FirstPersonPhysics.tscn")
