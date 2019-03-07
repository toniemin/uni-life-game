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

var tasks_left = {
	"MainBuilding": 3,
	"Linna": 3,
	"PinniA": 3,
	"PinniB": 3
} 

var player

var current_lvl
var current_lvl_name

var creditsCounter = 0

func _ready():
	player = Player_scene.instance()

	change_level(null, "Outdoors1", "default")


func change_level(source_lvl, dest_lvl_name, spawnpoint):
	var last_lvl = source_lvl
	current_lvl = levels[dest_lvl_name].instance()
	current_lvl_name = dest_lvl_name
	if last_lvl != null:
		free_level(last_lvl)
	set_level(current_lvl, spawnpoint)


func set_level(level, spawnpoint):
	add_child(level)
	
	get_tree().call_group("doors", "connect", "door_entered", self, "change_level")

	for door in get_tree().get_nodes_in_group("doors"):
		if not door.is_in_group("auto-open"):
			player.connect("action_pressed", door, "_on_Player_action_pressed")
	
	add_tasks(current_lvl_name)
	
	level.add_child(player)
	var level_bg = level.get_node("Sprite")
	var level_size = level_bg.texture.get_size()
	var level_scale = level_bg.global_scale
	player.set("position", level.find_node(spawnpoint).get("position"))
	player.set("clamp_x", level_size.x * level_scale.x)
	player.set("clamp_y", level_size.y * level_scale.y)

func add_tasks(level):
	var allTasks = get_tree().get_nodes_in_group("task")
	get_tree().call_group("tasks", "connect", "task_completed", self, "completeTask")
	var tasksToRemove = tasks_left[level]
	
	
func completeTask(task, lvl_name, credits):
	creditsCounter += credits
	tasks_left[lvl_name] -= 1
	current_lvl.removeChild(task)
	task.queue_free()

func free_level(level):
	level.remove_child(player)
	remove_child(level)
	level.queue_free()
	level = null