extends Node


export (PackedScene) var Mob
var score

func _ready():
    randomize()
	
func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.set_offset(randi())
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 1
	
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	# mob.rotation = direction
	# Choose the velocity.
	var random_direction = randf() * (1 - -1) + -1
	if(random_direction < 0):
		mob.find_node("AnimatedSprite").flip_h = true
	mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed) * random_direction, 0))

func _on_StartTimer_timeout():
	pass # replace with function body
