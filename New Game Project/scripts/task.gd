extends Area2D
#task.gd
signal task_completed

export (int) var credits = 5
export (String) var lvl_name

var completed = false

var player_in_task = false

func _ready():
	connect("body_entered", self, "_on_Task_body_entered")
	connect("body_exited", self, "_on_Task_body_exited")
	add_to_group("tasks")

func _on_Task_body_entered(body):
	player_in_task = true


func _on_Task_body_exited(body):
	player_in_task = false


func _on_Player_action_pressed(body):
	if player_in_task and body.is_in_group("player") and not completed:
		completed = true
		emit_signal("task_completed", self, lvl_name, credits)
