extends Area2D

signal door_entered

var source
export (String) var dest_lvl
export (String) var dest_spoint
export (bool) var active = false

func _ready():
	source = get_parent()
	
	connect("body_entered", self, "_on_DoorAutoActivate_body_entered")

func _on_DoorAutoActivate_body_entered(body):
	if active:
		emit_signal("door_entered", source, dest_lvl, dest_spoint)
	