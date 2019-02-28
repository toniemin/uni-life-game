extends Node

var Level1_scene = load("res://scenes/levels/teleport_test_master_v2.tscn")
var Level2_scene = load("res://scenes/levels/teleport_test_level2_master_v2.tscn")
var Player_scene = load("res://scenes/player/Player.tscn")

var levels = {
	"Level1": load("res://scenes/levels/teleport_test_master_v2.tscn"),
	"Level2": load("res://scenes/levels/teleport_test_level2_master_v2.tscn")
}

var Level1
var Level2

var current_lvl
var next_lvl

var player

func _init():
	player = Player_scene.instance()
	
	goto_level1(player)

func goto_level1(player):
	if Level2 != null:
		free_level(Level2)
	Level1 = Level1_scene.instance()
	set_level(Level1)
	

func goto_level2(player):
	if Level1 != null:
		free_level(Level1)
	Level2 = Level2_scene.instance()
	add_child(Level2)
	Level2.connect("door_entered", self, "goto_level1")
	player.connect("action_pressed", Level2, "_on_Player_action_pressed")
	Level2.add_child(player)
	var position = Level2.find_node("Area2D").get("position")
	player.set("position", position)

func switch_level(level):
	pass

func set_level(level):
	add_child(level)
	level.connect("door_entered", self, "switch_level")
	player.connect("action_pressed", level, "_on_Player_action_pressed")
	level.add_child(player)
	player.set("position", level.find_node("Area2D").get("position"))

func free_level(level):
	level.remove_child(player)
	remove_child(level)
	level.queue_free()
	level = null
	