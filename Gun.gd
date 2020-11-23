extends Spatial

export var Bullet: PackedScene = preload("res://Bullet2.tscn") if OS.get_name()=="Android" or OS.get_name()=="iOS" else preload("res://Bullet.tscn")

export var actions = ["VR_LEFT_INDEX_TRIGGER", "fire", "VR_SCREEN_TAP"]


func _process(_delta):
	for action in actions:
		if Input.is_action_just_pressed(action):
			$AudioStreamPlayer3D.play()
			var bullet = Bullet.instance()
			bullet.transform = self.get_global_transform()
			get_tree().current_scene.add_child(bullet)
		
		
