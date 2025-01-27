extends Moon

@export var hardcoded_position: bool = false
var next_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !hardcoded_position:
		position = get_viewport().get_visible_rect().size / 2
	var tween: Tween = create_tween()
	tween.tween_property(get_node("Blackout"), "modulate:a", 0.0, 1.0)
	#await tween.finished

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_player_too_close():
		var tween: Tween = create_tween()
		tween.tween_property(get_node("Blackout"), "modulate:a", 1.0, 2.0)
		await tween.finished
		
		ScoreStats.next_level()
