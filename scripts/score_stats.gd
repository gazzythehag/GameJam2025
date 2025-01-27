extends Node

var game_time: float = 0
var max_lives: int = 5
var player_lives: int:
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
	game_playing = false
	if player_lives > 0: get_tree().change_scene_to_file("res://scenes/victory.tscn")
	else: get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	pass
	
func start_game() -> void:
	game_time = 0
	player_lives = max_lives
	game_playing = true
	get_tree().change_scene_to_file("res://scenes/levels/levelA.tscn")

func next_level() -> void:
	print(get_tree().current_scene.name)
	match get_tree().current_scene.name:
		"LevelA":
			get_tree().change_scene_to_file("res://scenes/interstitials/ab_interstitial.tscn")
		"AB_interstitial":
			get_tree().change_scene_to_file("res://scenes/levels/levelB.tscn")
		"LevelB":
			get_tree().change_scene_to_file("res://scenes/interstitials/bc_interstitial.tscn")
		"BC_interstitial":
			get_tree().change_scene_to_file("res://scenes/levels/levelC.tscn")
		"LevelC":
			get_tree().change_scene_to_file("res://scenes/interstitials/cd_interstitial.tscn")
		"CD_interstitial":
			get_tree().change_scene_to_file("res://scenes/levels/levelD.tscn")
		"LevelD":
			get_tree().change_scene_to_file("res://scenes/interstitials/de_interstitial.tscn")
		"DE_interstitial":
			get_tree().change_scene_to_file("res://scenes/levels/levelE.tscn")
		"LevelE":
			get_tree().change_scene_to_file("res://scenes/interstitials/ef_interstitial.tscn")
		"EF_interstitial":
			get_tree().change_scene_to_file("res://scenes/levels/levelF.tscn")
		"LevelF":
			end_game()

func main_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/title.tscn")
	game_playing = false
