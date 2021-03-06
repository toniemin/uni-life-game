extends Area2D

signal door_entered

var source
export (String) var dest_lvl
export (String) var dest_spoint
export (bool) var active = true
export (bool) var auto_open = false

var player_in_teleporter = false

func _ready():
	source = get_parent()
	connect("body_entered", self, "_on_DoorOpenable_body_entered")
	connect("body_exited", self, "_on_DoorOpenable_body_exited")

func _on_DoorOpenable_body_entered(body):
	if auto_open and active and body.is_in_group("player"):
		disconnect("body_entered", self, "_on_DoorOpenable_body_entered")
		emit_signal("door_entered", source, dest_lvl, dest_spoint)
	else:
		player_in_teleporter = true


func _on_DoorOpenable_body_exited(body):
	player_in_teleporter = false


func _on_Player_action_pressed(body):
	if player_in_teleporter and active and body.is_in_group("player"):
		emit_signal("door_entered", source, dest_lvl, dest_spoint)
