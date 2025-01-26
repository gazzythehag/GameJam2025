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
var ellipse_c: float
## var loop_progress: float = 0 <-- MOVED TO MOONS

enum MODES { FIXED, CLOCKWISE, COUNTERCLOCKWISE }
@export var mode: MODES

var moons: Array:
	get: return get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ellipse_c = sqrt(ellipse_a*ellipse_a - ellipse_b*ellipse_b)
	for moon in moons: ## set initial position of moon (if fixed, it won't be set on the orbit)
		moon.position = Vector2(orbit_radius, 0)
		#moon.translate(Vector2(orbit_radius, 0))
	set_moon_pos()

func _draw() -> void:
	var coords_ellipse : Array = []
	# make all the points that define an ellipse, then draw the polyline connecting em
	for t in 1000:
		coords_ellipse.append(get_ellipse_position(2*PI*t/1000))
	draw_polyline(coords_ellipse, orbit_colour, -1,true)
	#draw_circle(Vector2(0,0), orbit_radius, orbit_colour, false, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match mode:
		MODES.FIXED:
			set_moon_pos()
		MODES.COUNTERCLOCKWISE:
			move_clockwise(delta)
			set_moon_pos()
		MODES.CLOCKWISE:
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
		moon.position = get_ellipse_position(moon.loop_progress)

# Returns the closest position on this ring's ellipse to a point passed to the function
func get_closest_pos(other_pos: Vector2) -> Vector2:
	var line_to_pos: Vector2 = other_pos - (global_position + orbit_radius*Vector2(ellipse_h, ellipse_k) )
	var dist: float = line_to_pos.length()
	var angle_from_centre: float = line_to_pos.angle()
	var pos = get_ellipse_position(angle_from_centre) + global_position
	return pos

# This function takes in an angle theta and then returns the x,y position on an ellipse
func get_ellipse_position(theta: float) -> Vector2:
	var ell_pos: Vector2 = orbit_radius * Vector2(ellipse_a * cos(theta) + ellipse_h, ellipse_b * sin(theta) + ellipse_k)
	return ell_pos

# Takes a position of another object and returns the angle of the vector pointing to that position
# from the ellipse's perspective
func get_ellipse_angle(other_pos: Vector2) -> float:
	var line_to_pos: Vector2 = other_pos - (global_position + orbit_radius*Vector2(ellipse_h, ellipse_k) )
	var angle_to_pos: float = line_to_pos.angle()
	return angle_to_pos
