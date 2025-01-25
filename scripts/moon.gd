#@tool
extends Node2D
class_name Moon

@export var radius: int = 10 # size of drawn circle
@export var centre_colour: Color
@export var loop_progress: float = 0:
	get: return loop_progress
	set(value): loop_progress = value

var rings: Array:
	get: return get_children()

func _init() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()

func _draw():
	draw_circle(Vector2(0,0), radius, centre_colour)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if loop_progress > 2*PI:
		loop_progress -= 2*PI
	elif loop_progress < 0:
		loop_progress += 2*PI
