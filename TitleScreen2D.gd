extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fire") or Input.is_action_just_pressed("VR_RIGHT_INDEX_TRIGGER") or Input.is_action_just_pressed("VR_LEFT_INDEX_TRIGGER"):
		get_tree().change_scene("res://main.tscn")
