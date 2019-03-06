extends RigidBody2D



func _ready():
	
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	pass

export (int) var min_speed # Minimum speed range.
export (int) var max_speed # Maximum speed range.
var mob_types = ["walk"]

func _on_VisibilityNotifier2D_screen_exited():
	pass # replace with function body
	
    
	
func _on_Visibility_screen_exited():
    queue_free()