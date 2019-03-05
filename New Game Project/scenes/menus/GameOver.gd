extends CanvasLayer

# Scene opened from StartButton.
const NEXT_SCENE = "res://scenes/misc/root_scene.tscn"

func _ready():

	# Connect signal handlers.
	find_node("QuitButton").connect("pressed", self, "_on_QuitButton_pressed")
	find_node("RestartButton").connect("pressed", self, "_on_RestartButton_pressed")
	
func _on_RestartButton_pressed():
	var tree = get_tree()
	tree.paused = false
	tree.reload_current_scene()
	queue_free()
	
	
	

func _on_QuitButton_pressed():
	get_tree().quit()