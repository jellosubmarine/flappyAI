extends Node2D

export (PackedScene) var Pipe

export (PackedScene) var Birdy
var rng = RandomNumberGenerator.new()
var score = -1

func _ready():
	rng.randomize()
	GlobalVariables.birdy_dead = 0
	var birdy = Birdy.instance()
	add_child(birdy)
	birdy.position = Vector2(133,378)
	
	
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
	score += 1

func _process(delta):
	if score < 0:
		get_node("Canvas/Interface/Score").text = str(0)
	else:
		get_node("Canvas/Interface/Score").text = str(score)
	if GlobalVariables.birdy_dead:
		get_tree().reload_current_scene()

func auto_jump_test():
	var birdies = get_node("Birdy")


#func _on_Birdy_birdy_dead():
	
