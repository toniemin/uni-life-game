extends Area2D

signal task_completed

export (int) var credits

var completed = false

var player_in_task = false

func _ready():
	connect("body_entered", self, "_on_DoorOpenable_body_entered")
	connect("body_exited", self, "_on_DoorOpenable_body_exited")
	add_to_group("tasks")

func _on_DoorOpenable_body_entered(body):
	player_in_task = true


func _on_DoorOpenable_body_exited(body):
	player_in_task = false


func _on_Player_action_pressed(body):
	if player_in_task and body.is_in_group("player"):
		completed = true
		emit_signal("task_completed", credits)
