extends Node2D

export (PackedScene) var Pipe

export (PackedScene) var Birdy
var rng = RandomNumberGenerator.new()
var score = -1
var body_count = 0

func _ready():
	rng.randomize()
	print("started")
	#Birds init
	GlobalVariables.in_vector.resize(GlobalVariables.NO_OF_BIRDS)
	GlobalVariables.alive_vector.resize(GlobalVariables.NO_OF_BIRDS)
	for i in range(len(GlobalVariables.alive_vector)):
		GlobalVariables.alive_vector[i] = 1
	for i in range(GlobalVariables.NO_OF_BIRDS):
		var birdy = Birdy.instance()
		add_child(birdy)
		birdy.connect("birdy_dead", self, "_on_Birdy_birdy_dead")
		birdy.position = Vector2(133,378)
		birdy.index = i
		
	
	
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
	
	GlobalVariables.toppipe_h = pipe_top.global_position.y+pipe_top.get_node("Pipe2D/PipeCollision").get_shape().extents[1]*2
	GlobalVariables.bottompipe_h = pipe_bottom.global_position.y-pipe_top.get_node("Pipe2D/PipeCollision").get_shape().extents[1]*2

	
	score += 1

func _process(_delta):
	if score < 0:
		get_node("Canvas/Interface/Score").text = str(0)
	else:
		get_node("Canvas/Interface/Score").text = str(score)

		


#func auto_jump_test():
#	var birdies = get_node("Birdy")


func _on_Birdy_birdy_dead():
	body_count += 1
	if body_count >= GlobalVariables.NO_OF_BIRDS:
		get_tree().reload_current_scene()
		GlobalVariables.toppipe_h = 0
		GlobalVariables.bottompipe_h = 0	
		GlobalVariables.pipe_x = 133
		body_count = 0
		
	
	print(body_count)
