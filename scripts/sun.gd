extends Moon

@export var hardcoded_position: bool = false
var next_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !hardcoded_position:
		position = get_viewport().get_visible_rect().size / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_player_too_close():
		ScoreStats.next_level()
