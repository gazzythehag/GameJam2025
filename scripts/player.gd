#@tool
extends Moon

@export var max_distance: float # the max distance the node can be from an orbit
@export var lives_label: RichTextLabel

var rings_in_level: Array
var parent_ring: Object
var lives: int = 3
var initialOrbit: Object

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rings_in_level = get_tree().get_nodes_in_group("rings") ## gets an array of all object in rings group
	## if a ring is not in the group it is not counted as interactable
	parent_ring = get_parent()
	initialOrbit = parent_ring

func _draw(): 
	draw_circle(Vector2(0,0), radius, centre_colour)

func _input(event):
	if event.is_action_pressed("ui_up"):
		jump_orbit_inward()
	if event.is_action_pressed("ui_down"):
		jump_orbit_outward()
	if event.is_action_pressed("ui_left"):
		player_boost = 0.5
	if event.is_action_released("ui_left"):
		player_boost = 1.0
	if event.is_action_pressed("ui_right"):
		player_boost = 2.0
	if event.is_action_released("ui_right"):
		player_boost = 1.0

func jump_orbit_inward(): 
	#lives_label.text = "Lives: " + str(lives)
	var closest_ring: Object = get_closest_ring(true)
	if closest_ring != parent_ring:
		jump(closest_ring)
		AudioHandler.get_node("InSound").play(0.26)

func jump_orbit_outward():
	var closest_ring: Object = get_closest_ring(false)
	if closest_ring != parent_ring:
		jump(closest_ring)
		AudioHandler.get_node("OutSound").play(0.32)

func jump(target: Object):
	loop_progress = (global_position - target.global_position).angle()
	reparent(target)
	parent_ring = target
	
# Returns the nearest ring within range to the player
# If all rings are out of range, returns the parent ring (the one which the player is currently on)
func get_closest_ring(inward: bool) -> Object:
	var closest_ring: Object
	var closest: float = 2000000 #temp, just trying to puzzle this out
	closest_ring = get_parent()
	for ring in rings_in_level:
		if ring != get_parent():
			#var distance = abs((ring.global_position - global_position).length() - ring.orbit_radius)
			var distance: float = abs((ring.get_closest_pos(global_position) - global_position).length())
			if distance < closest and distance < max_distance:
				if is_ring_valid(inward, ring):
					closest = distance
					closest_ring = ring
	return closest_ring

func is_ring_valid(inward: bool, target: Object) -> bool:
	var dist_to_ring: float = (target.get_closest_pos(global_position) - get_viewport().get_visible_rect().size / 2).length()
	var dist_to_player: float = (global_position - get_viewport().get_visible_rect().size / 2).length()
	if dist_to_player > dist_to_ring and inward: return true
	elif dist_to_player < dist_to_ring and !inward: return true
	else: return false

#func is_ring_valid(inward: bool, target: Object) -> bool:
#	var parent_ring_index: int = rings_in_level.find(get_parent())
#	for i in rings_in_level.size():
#		if rings_in_level[i] == target:
#			if i < parent_ring_index and inward: return true
#			elif i > parent_ring_index and !inward: return true
#	return false

func lose_life() -> void:
	reparent(initialOrbit)
	parent_ring = initialOrbit
	ScoreStats.damage_player()
