#@tool
extends Node2D
class_name OrbitRing

@export var orbit_radius: int = 100
@export var orbit_colour: Color
@export var angular_speed: float = 10

@export var ellipse_a: float = 1.0
@export var ellipse_b: float = 1.0
@export var ellipse_h: float = 0.0
@export var ellipse_k: float = 0.0
## var loop_progress: float = 0 <-- MOVED TO MOONS

enum MODES { FIXED, CLOCKWISE, COUNTERCLOCKWISE }
@export var mode: MODES

var moons: Array:
	get: return get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for moon in moons: ## set initial position of moon (if fixed, it won't be set on the orbit)
		moon.position = Vector2(orbit_radius, 0)
		#moon.translate(Vector2(orbit_radius, 0))
	set_moon_pos()

func _draw() -> void:
	var coords_ellipse : Array = []
	for t in 1000:
		coords_ellipse.append(orbit_radius * Vector2(ellipse_a * cos(2*PI*t/1000) + ellipse_h, ellipse_b * sin(2*PI*t/1000) + ellipse_k))
	draw_polyline(coords_ellipse, orbit_colour, -1,true)
	#draw_circle(Vector2(0,0), orbit_radius, orbit_colour, false, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match mode:
		MODES.FIXED:
			pass
		MODES.CLOCKWISE:
			move_clockwise(delta)
			set_moon_pos()
		MODES.COUNTERCLOCKWISE:
			move_counterclockwise(delta)
			set_moon_pos()

func move_clockwise(delta: float):
	for moon in moons:
		moon.loop_progress -= delta * angular_speed
		
func move_counterclockwise(delta: float):
	for moon in moons:
		moon.loop_progress += delta * angular_speed

func set_moon_pos():
	for moon in moons:
		moon.position = orbit_radius * Vector2(ellipse_a * cos(moon.loop_progress) + ellipse_h, ellipse_b * sin(moon.loop_progress) + ellipse_k)

#func get_closest_pos(other_pos: Vector2) -> Vector2:
#	pass
	#var pos = orbit_radius * Vector2(cos(loop_progress), sin(loop_progress))
	#return pos
