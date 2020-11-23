extends Spatial


func _ready():
	translate(Vector3(0,0,-0.2))


func _process(delta):
	translate(Vector3(0,0,delta*-5))


func _on_Timer_timeout():
	queue_free()


func _on_Bullet_area_entered(area):
	if area.has_method("bullet_hit"):
		area.bullet_hit(10)
		queue_free()
