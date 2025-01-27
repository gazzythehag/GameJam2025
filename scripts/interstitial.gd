extends Control

var clock_time = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween: Tween = create_tween()
	print("FADE IN")
	tween.tween_property(get_node("Blackout"), "modulate:a", 0.0, 1.0)
	clock_time = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	clock_time += delta
	if (clock_time >= 3):
		ScoreStats.next_level()
