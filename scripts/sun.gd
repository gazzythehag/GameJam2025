extends Moon

var next_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	match get_parent().name:
		"LevelA":
			next_scene = preload("res://scenes/levels/levelB.tscn")
		"LevelB":
			next_scene = preload("res://scenes/levels/levelC.tscn")
		"LevelC":
			next_scene = preload("res://scenes/levels/levelD.tscn")
		"LevelD":
			next_scene = preload("res://scenes/levels/levelE.tscn")
		"LevelE":
			next_scene = preload("res://scenes/levels/levelF.tscn")
		"LevelF":
			next_scene = preload("res://scenes/title.tscn")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_player_too_close():
		get_tree().change_scene_to_packed(next_scene)
	pass
