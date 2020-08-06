extends KinematicBody2D
#
var velocity = Vector2(-5,0)

func _physics_process(delta):
	move_and_collide(Vector2(-3, 0))


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
	print("Deleted")
