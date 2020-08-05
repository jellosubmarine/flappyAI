extends KinematicBody2D

var velocity = Vector2(-5,0)

# Called when the node enters the scene tree for the first time.
func _ready():	
	pass
	

func _physics_process(delta):
	move_and_collide(velocity)
