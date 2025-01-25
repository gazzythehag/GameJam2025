extends Node2D

@export var orbit_radius: int = 100
@export var orbit_colour: Color
@export var fixed: bool
@export var angular_speed: float = 10
var loop_progress: float = 0

var moons: Array:
	get: return get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_parent().position)
	#for moon in moons:
		#moon.translate(Vector2(orbit_radius, 0))

func _draw() -> void:
	draw_circle(Vector2(0,0), orbit_radius, orbit_colour, false, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	loop_progress += delta * angular_speed
	for moon in moons:
		moon.position = orbit_radius * Vector2(sin(loop_progress), cos(loop_progress))
