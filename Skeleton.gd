extends Area

onready var target = get_tree().root.find_node("Player", true, false)

var dead = false

func _ready():
	$spawnSound.play()
	$AnimationPlayer.play("Skeleton_Spawn")

func _process(delta):
	if $AnimationPlayer.current_animation=="Skeleton_Running":
		look_at(target.global_transform.origin, Vector3.UP)
		rotation_degrees.x = 0
		translate(Vector3(0,0,delta*-5.0))



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="Skeleton_Spawn":
		$AnimationPlayer.play("Skeleton_Running")
	elif anim_name=="Skeleton_Running":
		$AnimationPlayer.play("Skeleton_Running")
	elif anim_name=="Skeleton_Death":
		queue_free()
		
func bullet_hit(damage):
	if not dead:
		dead = true
		$deathSound.play()
		$AnimationPlayer.play("Skeleton_Death")
		Globals.emit_signal("score_points", 1)


func _on_Skeleton_area_entered(area):
	if area.has_method("enemy_hit"):
		area.enemy_hit(10)
		queue_free()
