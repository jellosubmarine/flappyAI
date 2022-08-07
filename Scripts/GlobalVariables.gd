extends Node

const NO_OF_BIRDS = 100

var score = -1

#height of the edge of the top pipe
var toppipe_h = 0
#height of the edge of the bottom pipe
var bottompipe_h = 0
#current_pipe_location
var pipe_x = 133
#current bird location
var bird_y = []
#current input vector
var in_vector = []
#0 if dead, 1 if alive
var alive_vector = []
#distance from the top and bottom pipes for each bird instance
var top_pipe_dist = []
var bottom_pipe_dist = []

var generation = 1
