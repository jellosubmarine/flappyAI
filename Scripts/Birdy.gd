extends KinematicBody2D

export (int) var index = 0

const jump_speed = -8
const gravity = 24

signal birdy_dead

var velocity = Vector2(0,0)

func get_input():
	var jump = Input.is_action_just_pressed('ui_select')

	if jump:
		velocity.y = jump_speed

func ai_input():
	if GlobalVariables.in_vector[index]:
		velocity.y = jump_speed


func _physics_process(delta):
	get_input()
#	ai_input()
	velocity.y += gravity * delta
	move_and_collide(velocity)
#	if GlobalVariables.birdy_dead:
#		emit_signal("birdy_dead")
#		queue_free()
	GlobalVariables.top_pipe_dist[index] = sqrt(pow(self.global_position.y - GlobalVariables.toppipe_h,2)+pow(GlobalVariables.pipe_x,2))
	GlobalVariables.bottom_pipe_dist[index] = sqrt(pow(self.global_position.y - GlobalVariables.bottompipe_h,2)+pow(GlobalVariables.pipe_x,2))
	GlobalVariables.bird_y[index] = self.global_position.y
func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	if GlobalVariables.alive_vector[index] == 1:
		die()
	
func die():
	GlobalVariables.alive_vector[index] = 0
	emit_signal("birdy_dead")
	queue_free()
