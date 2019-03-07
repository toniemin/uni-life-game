extends TextureProgress

signal timer_end

var timer

func _init():
	timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.set_wait_time(max_value)
	timer.set_one_shot(true)
	timer.set_timer_process_mode(Timer.TIMER_PROCESS_IDLE)
	
	add_child(timer)
	timer.start()

func _process(delta):
	set_value(timer.time_left)
	
func _on_timer_timeout():
	var tree = get_tree()
	var game_over_screen = load("res://scenes/menus/GameOver.tscn").instance()
	game_over_screen.set("credits", tree.get_root().get_node("Master").get("credits_counter"))
	tree.get_root().add_child(game_over_screen)
	tree.paused = true
	pass