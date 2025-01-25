#@tool
extends Moon

@export var max_distance: float # the max distance the node can be from an orbit

var rings_in_level: Array
var parent_ring: Object

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rings_in_level = get_tree().get_nodes_in_group("rings")
	parent_ring = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(get_relative_transform_to_parent(get_parent()).origin)
	pass

func _draw():
	draw_circle(Vector2(0,0), radius, centre_colour)

func _input(event):
	if event.is_action_pressed("ui_up"):
		jump_orbit_inward()
	if event.is_action_pressed("ui_down"):
		jump_orbit_outward()

func jump_orbit_inward(): 
	## i don't like that these two methods are so similar
	##	but I'm still trying to hash out the details
	var closest_ring: Object = get_closest_ring()
	#print("Distance between " + str(closest_ring.global_position) + " and " + str(global_position) + " is " + str(global_position.distance_to(closest_ring.global_position)))
	var line_to_me = global_position - closest_ring.global_position
	#loop_progress = asin(line_to_me.y)
	if closest_ring != parent_ring:
		reparent(closest_ring)
		parent_ring = closest_ring
	#print(parent_ring)

func jump_orbit_outward():
	var closest_ring: Object = get_closest_ring()
	var line_to_me = global_position - closest_ring.global_position
	#loop_progress = asin(line_to_me.y)
	reparent(closest_ring)
	
	#print(parent_ring)

func get_closest_ring() -> Object:
	var closest_ring: Object
	var closest: float = 2000000 #temp, just trying to puzzle this out
	closest_ring = get_parent()
	for ring in rings_in_level:
		if ring != get_parent():
			var distance = abs((ring.global_position - global_position).length() - ring.orbit_radius)
			if distance < closest and distance < max_distance:
				closest = distance
				closest_ring = ring
	return closest_ring
