extends Node2D

export (PackedScene) var Pipe
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	
func _input(event):
	if event.is_action_pressed("click"):
		var new_ball = Pipe.instance()
		add_child(new_ball)
		new_ball.position = get_viewport().get_mouse_position()
		var r = rng.randf_range(0.5,1.2)
		#new_ball.get_node("Pipe2D/PipeCollision").scale = Vector2(1, r)
		#new_ball.get_node("Pipe2D/PipeCollision/PipeSprite").scale = new_ball.get_node("Pipe2D/PipeCollision/PipeSprite").scale*Vector2(1, r)


func _on_Timer_timeout():
	var pipe_top = Pipe.instance()
	add_child(pipe_top)
	var pipe_bottom = Pipe.instance()
	add_child(pipe_bottom)


	pipe_top.position = Vector2(get_viewport().size.x,-500)

	pipe_bottom.set_rotation_degrees(180)
	pipe_bottom.position = Vector2(get_viewport().size.x,get_viewport().size.y)
	
	
	
	
	var r = rng.randf_range(0.5,1.2)
	
	#new_pipe.get_node("Pipe2D/PipeCollision").scale = Vector2(1, r)
	#new_pipe.get_node("Pipe2D/PipeCollision/PipeSprite").scale = new_pipe.get_node("Pipe2D/PipeCollision/PipeSprite").scale*Vector2(1, r)
