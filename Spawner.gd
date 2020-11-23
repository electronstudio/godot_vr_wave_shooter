extends Spatial

var Skeleton = preload("res://Skeleton.tscn")

func _ready():
	start_timer()

func _on_Timer_timeout():
	var skeleton = Skeleton.instance()
	skeleton.transform = self.get_global_transform()
	get_tree().current_scene.add_child(skeleton)
	start_timer()

func start_timer():
	$Timer.wait_time = rand_range(3, 50 - Globals.wave*10)
	$Timer.start()
