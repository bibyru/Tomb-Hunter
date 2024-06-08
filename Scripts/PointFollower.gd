extends Node2D

@export var sharpbox : Node2D
@export var point1 : Node2D
@export var point2 : Node2D

var points
var index = 0

@export var speed = .05
var limit = .1

func _ready():
	if point1 && point2:
		points = [point1.position, point2.position]

func _process(delta):
	
	if point1 && point2:
		var distance : Vector2 = abs(points[index] - sharpbox.position)
		if (distance.x <= limit && distance.y <= limit):
			index = index +1
			if (index >= 2):
				index = 0
		
		sharpbox.position.x = move_toward(sharpbox.position.x, points[index].x, speed)
		sharpbox.position.y = move_toward(sharpbox.position.y, points[index].y, speed)
