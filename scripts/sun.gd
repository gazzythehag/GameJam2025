extends Moon

var next_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport().get_visible_rect().size / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_player_too_close():
		match get_parent().name:
			"LevelA":
				get_tree().change_scene_to_file("res://scenes/levels/levelB.tscn")
			"LevelB":
				get_tree().change_scene_to_file("res://scenes/levels/levelC.tscn")
			"LevelC":
				get_tree().change_scene_to_file("res://scenes/levels/levelD.tscn")
			"LevelD":
				get_tree().change_scene_to_file("res://scenes/levels/levelE.tscn")
			"LevelE":
				get_tree().change_scene_to_file("res://scenes/levels/levelF.tscn")
			"LevelF":
				get_tree().change_scene_to_file("res://scenes/title.tscn")
	pass
