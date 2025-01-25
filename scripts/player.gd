#@tool
extends Moon

@export var max_distance: float # the max distance the node can be from an orbit

var rings_in_level: Array
var parent_ring: Object

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rings_in_level = get_tree().get_nodes_in_group("rings")
	print(rings_in_level)
	parent_ring = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#print(get_relative_transform_to_parent(get_parent()).origin)
#	pass

func _draw():
	draw_circle(Vector2(0,0), radius, centre_colour)

func _input(event):
	if event.is_action_pressed("ui_up"):
		jump_orbit_inward()
	if event.is_action_pressed("ui_down"):
		jump_orbit_outward()

func jump_orbit_inward(): 
	var closest_ring: Object = get_closest_ring(true)
	var line_to_me = closest_ring.global_position - global_position
	if (line_to_me.x < 0):
		loop_progress = atan(line_to_me.y/line_to_me.x)
	else:
		loop_progress = atan(line_to_me.y/line_to_me.x) + PI
	if closest_ring != parent_ring:
		reparent(closest_ring)
		parent_ring = closest_ring

func jump_orbit_outward():
	var closest_ring: Object = get_closest_ring(false)
	var line_to_me = closest_ring.global_position - global_position
	if (line_to_me.x < 0):
		loop_progress = atan(line_to_me.y/line_to_me.x)
	else:
		loop_progress = atan(line_to_me.y/line_to_me.x) + PI
	reparent(closest_ring)

func get_closest_ring(inward: bool) -> Object:
	var closest_ring: Object
	var closest: float = 2000000 #temp, just trying to puzzle this out
	closest_ring = get_parent()
	for ring in rings_in_level:
		if ring != get_parent():
			var distance = abs((ring.global_position - global_position).length() - ring.orbit_radius)
			if distance < closest and distance < max_distance:
				if is_ring_valid(inward, ring):
					closest = distance
					closest_ring = ring
	return closest_ring

func is_ring_valid(inward: bool, target: Object) -> bool:
	var parent_ring_index: int = rings_in_level.find(get_parent())
	for i in rings_in_level.size():
		if rings_in_level[i] == target:
			if i < parent_ring_index and inward: return true
			elif i > parent_ring_index and !inward: return true
	return false
