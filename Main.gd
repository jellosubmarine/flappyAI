extends Node2D

export (PackedScene) var Pipe
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	GlobalVariables.birdy_dead = 0
	
func _on_Timer_timeout():
	var pipe_top = Pipe.instance()
	add_child(pipe_top)
	var pipe_bottom = Pipe.instance()
	add_child(pipe_bottom)

	var r = rng.randi_range(0,400)


	pipe_top.position = Vector2(get_viewport().size.x+26,-400+r)

	pipe_bottom.set_rotation_degrees(180)
	pipe_bottom.get_node("Pipe2D/PipeCollision/PipeSprite").set_flip_h( true )
	pipe_bottom.position = Vector2(get_viewport().size.x+26,get_viewport().size.y+r)


	
	
	#new_pipe.get_node("Pipe2D/PipeCollision").scale = Vector2(1, r)
	#new_pipe.get_node("Pipe2D/PipeCollision/PipeSprite").scale = new_pipe.get_node("Pipe2D/PipeCollision/PipeSprite").scale*Vector2(1, r)


func _on_Birdy_birdy_dead():
	get_tree().reload_current_scene()
