extends Node

signal scoreChanged

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
	"PinniB": 3,
	"Outdoors1": 0,
	"Outdoors2": 0
} 

var player

var current_lvl
var current_lvl_name

var creditsCounter = 0

var init = true

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
	
	if init:
		var timer = get_tree().get_nodes_in_group("timer")[0]
		connect("scoreChanged", timer, "updateScore")
		
		init = false
	
	var level_bg = level.get_node("Sprite")
	var level_size = level_bg.texture.get_size()
	var level_scale = level_bg.global_scale
	player.set("position", level.find_node(spawnpoint).get("position"))
	player.set("clamp_x", level_size.x * level_scale.x)
	player.set("clamp_y", level_size.y * level_scale.y)

func add_tasks(level):
	print('adding tasks')
	var allTasks = get_tree().get_nodes_in_group("tasks")
	print('tasks: ', allTasks)
	get_tree().call_group("tasks", "connect", "task_completed", self, "completeTask")
	
	for task in allTasks:
		player.connect("action_pressed", task, "_on_Player_action_pressed")
	
	var tasksToRemove = 0
	if (tasks_left.has(level)):
		tasksToRemove = 3 - tasks_left[level]
	var i = 0
	for task in allTasks:
		if i <= tasksToRemove:
			print('removing task')
			task.queue_free()
			i += 1
		else:
			break
	
	
func completeTask(task, lvl_name, credits):
	creditsCounter += credits
	emit_signal("scoreChanged", creditsCounter)
	#tasks_left[lvl_name] = tasks_left[lvl_name] - 1
	task.queue_free()

func free_level(level):
	level.remove_child(player)
	remove_child(level)
	level.queue_free()
	level = null
	
