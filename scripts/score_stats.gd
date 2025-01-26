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
		AudioHandler.get_node("HitSound").play()
	else:
		AudioHandler.get_node("Song1").stop()
		AudioHandler.get_node("Song2").stop()
		AudioHandler.get_node("DeathSound").play()
		end_game()

func end_game() -> void:
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	pass
	
func start_game() -> void:
	game_time = 0
	player_lives = 3
	game_playing = true
	get_tree().change_scene_to_file("res://scenes/levels/levelA.tscn")

func next_level() -> void:
	print(get_tree().current_scene.name)
	match get_tree().current_scene.name:
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
			get_tree().change_scene_to_file("res://scenes/game_over.tscn") ## Maybe make a game over / win scene

func main_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/title.tscn")
