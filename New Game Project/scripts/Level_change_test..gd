extends Node

var Level1_scene = load("res://scenes/levels/teleport_test_master_v2.tscn")
var Level2_scene = load("res://scenes/levels/teleport_test_level2_master_v2.tscn")
var Player_scene = load("res://scenes/player/Player.tscn")

var Level1
var Level2

var player

func _init():
	player = Player_scene.instance()
	
	goto_level1(player)

func goto_level1(player):
	if Level2 != null:
		Level2.remove_child(player)
		remove_child(Level2)
		Level2.queue_free()
		Level2 = null
	Level1 = Level1_scene.instance()
	add_child(Level1)
	Level1.connect("door_entered", self, "goto_level2")
	player.connect("action_pressed", Level1, "_on_Player_action_pressed")
	Level1.add_child(player)
	var position = Level1.find_node("Area2D").get("position")
	player.set("position", position)
	

func goto_level2(player):
	if Level1 != null:
		Level1.remove_child(player)
		remove_child(Level1)
		Level1.queue_free()
		Level1 = null
	Level2 = Level2_scene.instance()
	add_child(Level2)
	Level2.connect("door_entered", self, "goto_level1")
	player.connect("action_pressed", Level2, "_on_Player_action_pressed")
	Level2.add_child(player)
	var position = Level2.find_node("Area2D").get("position")
	player.set("position", position)
	