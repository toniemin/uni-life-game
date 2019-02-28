extends Node

var Player_scene = load("res://scenes/player/Player.tscn")

var levels = {
	"Outdoors1": load("res://scenes/levels/Outdoors1.tscn"),
	"Outdoors2": load("res://scenes/levels/Outdoors2.tscn"),
	"MainBuilding": load("res://scenes/levels/MainBuilding.tscn"),
	"Linna": load("res://scenes/levels/Linna.tscn"),
	"PinniA": load("res://scenes/levels/PinniA.tscn"),
	"PinniB": load("res://scenes/levels/PinniB.tscn")
}

var player

var current_lvl

func _ready():
	player = Player_scene.instance()
	
	change_level(null, "Outdoors1", "default")
	
	
func change_level(source_lvl, dest_lvl_name, spawnpoint):
	var last_lvl = source_lvl
	current_lvl = levels[dest_lvl_name].instance()
	if last_lvl != null:
		free_level(last_lvl)
	set_level(current_lvl, spawnpoint)
	

func set_level(level, spawnpoint):
	add_child(level)
	get_tree().call_group("doors", "connect", "door_entered", self, "change_level")
	
	for door in get_tree().get_nodes_in_group("doors"):
		player.connect("action_pressed", door, "_on_Player_action_pressed")
	
	level.add_child(player)
	player.set("position", level.find_node(spawnpoint).get("position"))

func free_level(level):
	level.remove_child(player)
	remove_child(level)
	level.queue_free()
	level = null