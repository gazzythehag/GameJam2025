extends Node2D

@export var radius: int = 10
@export var centre_colour: Color
var loop_progress: float = 0

var rings: Array:
	get: return get_children()

func _init() -> void:
	loop_progress = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()

func _draw():
	draw_circle(Vector2(0,0), radius, centre_colour)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func move(speed: Vector2) -> void:
	pass
