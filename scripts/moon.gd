@tool
extends Node2D
class_name Moon

@onready var player = get_tree().get_nodes_in_group("player")[0]
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
	print(player)
	queue_redraw()

func _draw():
	draw_circle(Vector2(0,0), radius, centre_colour)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_player_too_close() and player.name != name:
		print("Player collision detected")
	normalize_loop_progress()

func normalize_loop_progress() -> void:
	if loop_progress > 2*PI:
		loop_progress -= 2*PI
	elif loop_progress < 0:
		loop_progress += 2*PI

func is_player_too_close() -> bool:
	var player_distance = global_position.distance_to(player.global_position)
	print(str(player_distance) + " from " + name)
	if player_distance <= player.radius + radius: return true
	else: return false
