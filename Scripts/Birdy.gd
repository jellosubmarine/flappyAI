extends KinematicBody2D

export (int) var jump_speed = -8
export (int) var gravity = 24
export (int) var index = 200

signal birdy_dead

var floating = 1
var velocity = Vector2(0,0)



func get_input():
	var jump = Input.is_action_just_pressed('ui_select')

	if jump:
		floating = 0
		velocity.y = jump_speed

func ai_input():
	if GlobalVariables.in_vector[index]:
		floating = 0
		velocity.y = jump_speed


func _physics_process(delta):
#	get_input()
	ai_input()
	if not floating:
		velocity.y += gravity * delta
		move_and_collide(velocity)
#	if GlobalVariables.birdy_dead:
#		emit_signal("birdy_dead")
#		queue_free()
	GlobalVariables.top_pipe_dist[index] = self.global_position.y - GlobalVariables.toppipe_h
	GlobalVariables.bottom_pipe_dist[index] = self.global_position.y - GlobalVariables.bottompipe_h

func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	if GlobalVariables.alive_vector[index] == 1:
		die()
	
func die():
	GlobalVariables.alive_vector[index] = 0
	emit_signal("birdy_dead")
	queue_free()
