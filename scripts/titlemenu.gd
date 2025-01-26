extends Control

var first_level: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioHandler.get_node("TitleMusic").play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	AudioHandler.get_node("TitleMusic").stop()
	AudioHandler.get_node("Song1").play()
	ScoreStats.start_game()
	pass # Replace with function body.
