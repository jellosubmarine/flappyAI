extends Area2D
#
var velocity = Vector2(-5,0)

func _physics_process(_delta):
	self.global_position += Vector2(-3.5, 0)


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	queue_free()
	print("Deleted")


func _on_Pipe2D_body_entered(body):
	if body.get_name() == "Birdy":
		GlobalVariables.birdy_dead = 1
		print("ough")
