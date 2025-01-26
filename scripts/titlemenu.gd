extends Control

var first_level: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	first_level = preload("res://scenes/levels/levelA.tscn")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)
	pass # Replace with function body.
