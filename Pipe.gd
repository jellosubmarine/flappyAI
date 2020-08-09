extends Area2D
#
var velocity = Vector2(-5,0)

func _process(_delta):
	var pos = self.global_position.x - get_node("PipeCollision").get_shape().extents[0]
	if pos > 133:
		GlobalVariables.pipe_x = pos

func _physics_process(_delta):
	self.global_position += Vector2(-3.5, 0)

func _on_VisibilityNotifier2D_viewport_exited(_viewport):
#	t.start(1)
#	yield(t, "timeout")
#	t.queue_free()
	yield(get_tree().create_timer(1.0), "timeout")
	call_deferred("queue_free")


func _on_Pipe2D_body_entered(body):
	if body.get_name() == "Birdy":
		body.die()
		print("ough")
		

