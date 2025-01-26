extends Node

var game_time: float = 0
var player_lives: int = 3:
	get: return player_lives
	set(value): player_lives = value
var game_playing: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_playing:
		game_time += delta

func damage_player() -> void:
	player_lives -= 1
	if player_lives > 0:
		#lives_label.text = "Lives: " + str(lives)
		#get_node("HitSound").play()
		AudioHandler.get_node("HitSound").play()
	else:
		AudioHandler.get_node("Song1").stop()
		AudioHandler.get_node("Song2").stop()
		AudioHandler.get_node("DeathSound").play()
		get_tree().change_scene_to_file("res://scenes/title.tscn")

func end_game() -> void:
	pass
	
func start_game() -> void:
	game_time = 0
	player_lives = 3
	game_playing = true
	get_tree().change_scene_to_file("res://scenes/levels/levelA.tscn")

func next_level() -> void:
	match get_tree().current_scene.name:
		"levelA":
			get_tree().change_scene_to_file("res://scenes/levels/levelB.tscn")
		"levelB":
			get_tree().change_scene_to_file("res://scenes/levels/levelC.tscn")
		"levelC":
			get_tree().change_scene_to_file("res://scenes/levels/levelD.tscn")
		"levelD":
			get_tree().change_scene_to_file("res://scenes/levels/levelE.tscn")
		"levelE":
			get_tree().change_scene_to_file("res://scenes/levels/levelF.tscn")
		"levelF":
			get_tree().change_scene_to_file("res://scenes/title.tscn") ## Maybe make a game over / win scene
