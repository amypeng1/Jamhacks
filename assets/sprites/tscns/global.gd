extends Node

var ramen_made: bool = false
var compdone: bool = false
var touchgrass: bool = false

var music_player: AudioStreamPlayer

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	var music_track = load("res://assets/backgrounds/boogie-pecan-pie-main-version-41135-02-14.mp3") 
	music_player.stream = music_track
	
	# 5. Play the music immediately!
	music_player.play()
