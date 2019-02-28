extends CollisionShape2D

signal door_entered

export (String) var source
export (String) var dest

var player_in_teleporter = false

func _on_Teleport_body_entered(body):
	player_in_teleporter = true


func _on_Teleport_body_exited(body):
	player_in_teleporter = false


func _on_Player_action_pressed(body):
	print(body)
	if player_in_teleporter:
		emit_signal("door_entered", source, dest)
