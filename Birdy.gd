extends KinematicBody2D

export (int) var jump_speed = -8
export (int) var gravity = 24
signal birdy_dead
var floating = 1
var velocity = Vector2(0,0)

func get_input():
	var jump = Input.is_action_just_pressed('ui_select')

	if jump:
		floating = 0
		velocity.y = jump_speed

func _physics_process(delta):
	get_input()
	if not floating:
		velocity.y += gravity * delta
		move_and_collide(velocity)
	if GlobalVariables.birdy_dead:
		emit_signal("birdy_dead")
		queue_free()


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	emit_signal("birdy_dead")
	queue_free()
