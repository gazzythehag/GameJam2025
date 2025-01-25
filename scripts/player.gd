@tool
extends Moon

var rings_in_level: Array:
	get: return get_tree().get_nodes_in_group("rings")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(get_relative_transform_to_parent(get_parent()).origin)
	pass

func _draw():
	draw_circle(Vector2(0,0), radius, centre_colour)

func _input(event):
	if event.is_action_pressed("jump"):
		jump_orbit()

func jump_orbit():
	var closest_ring: Object
	var closest: float = 200000 #temp, just trying to puzzle this out
	for ring in rings_in_level:
		var distance = position.distance_to(ring.get_closest_pos(loop_progress))
		if distance < closest and ring != get_parent():
			closest = distance
			closest_ring = ring
	reparent(closest_ring)
