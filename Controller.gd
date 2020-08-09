extends Node2D

var temp_counter = 0

func _ready():
	GlobalVariables.in_vector.resize(GlobalVariables.NO_OF_BIRDS)

func _physics_process(_delta):
	if temp_counter == 5:
		GlobalVariables.in_vector[0] = 0
	else:
		GlobalVariables.in_vector[0] = 0
	if temp_counter == 30:
		GlobalVariables.in_vector[1] = 1
	else:
		GlobalVariables.in_vector[1] = 0
	temp_counter += 1
	if temp_counter > 30:
		temp_counter = 0
