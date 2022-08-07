extends Control


func _ready():
	set_process(true)
	$Generation.text = "Gen: " + str(GlobalVariables.generation)

func _process(_delta):
	update()
	
func _draw():
	draw_line(Vector2(133,GlobalVariables.toppipe_h), Vector2(get_viewport().size.x, GlobalVariables.toppipe_h), Color(255, 0, 0), 1)
	draw_line(Vector2(133,GlobalVariables.bottompipe_h), Vector2(get_viewport().size.x, GlobalVariables.bottompipe_h), Color(255, 0, 0), 1)
	draw_line(Vector2(133,50), Vector2(GlobalVariables.pipe_x, 50), Color(255, 0, 0), 1)
