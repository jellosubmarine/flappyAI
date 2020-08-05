extends KinematicBody2D

var velocity = Vector2(-5,0)

# Called when the node enters the scene tree for the first time.
func _ready():	
	pass
	

func _physics_process(delta):
	move_and_collide(velocity)

extends KinematicBody2D

var max_extent_dim = 100 #2 * maximum heigt/width allowed
var min_extent_dim = 10 #2 * minimum height/width allowed

var rect_width = 50 #width of the "pipes"

var shape_owner_ids = Array() #list of shape owner indices, stored in order to delete them later
var rects = Array() #a list of recs, will be used for drawing the rectangle

var color = Color(0,0.7,0) #green color

func _ready():
	randomize()

	#Demostrating the create_rectangle function
	create_rectangle(Vector2(100, 0))
	create_rectangle(Vector2(200, 0))

func _input(event):
	#Demonstrating the remove_rectangle function
	if(event.is_action_pressed("ui_cancel")):
		#Destroying the first shape in the array

		if(rects.size() > 0):
			remove_rectangle(0)

func _physics_process(delta):
	#Movement, scrolling to the side at speed 50px/s
	move_and_slide(Vector2(-50, 0))

func _draw():
	#Drawing the rectangles 
	for rect in rects:
		draw_rect(rect, color)

func create_rectangle(position):
	#Makes a new rectangle at the given position

	#Random rectangle dimensions
	var extents = Vector2()
	extents.x = rect_width/2
	extents.y = min_extent_dim + (max_extent_dim - min_extent_dim)*randf()
	
	#Making the collision shape
	var box = RectangleShape2D.new()
	box.extents = extents

	#Adding the shape to the KinematicBody2D
	var shape_owner = Node2D.new()
	shape_owner.translate(position)
	self.add_child(shape_owner)

	var shape_owner_id = create_shape_owner(shape_owner) #returns an int ID
	shape_owner_add_shape(shape_owner_id, box)

	shape_owner_ids.append(shape_owner_id)

	#Adding a rect to the list to be drawn
	rects.append(Rect2(position.x-extents.x, position.y-extents.y, 2*extents.x, 2*extents.y))
	update() #this calls the draw function

	pass

func remove_rectangle(index):
	#Deletes the rectangle corresponding to rects[index]/shape_owner_ids[index]
	if(index < rects.size()): #assuming no bug and shape_owner_ids is the same length
		rects.remove(index)
		
		var shape_owner_id = shape_owner_ids[index]
		shape_owner_ids.remove(index)

		var shape_owner = shape_owner_get_owner(shape_owner_id)
		self.remove_shape_owner(shape_owner_id)
		shape_owner.queue_free()
		
		update()	
