extends Node

func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Sounds and music/Arkansas_Traveler.ogg")
	player.play()