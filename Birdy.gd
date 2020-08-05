extends KinematicBody2D

export (int) var jump_speed = -8
export (int) var gravity = 24

var velocity = Vector2(0,0)

func get_input():
	var jump = Input.is_action_just_pressed('ui_select')

	if jump:
		velocity.y = jump_speed

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	move_and_collide(velocity)
