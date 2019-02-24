extends PopupPanel

func _ready():
	$ContinueBtn.connect("pressed", this, "_on_ContinueBtn_pressed")
	$QuitBtn.connect("pressed", this, "_on_QuitBtn_pressed")
	connect("about_to_show", this, "_on_about_to_show")
	

func _on_about_to_show():
	get_tree().paused = true
	

func _on_ContinueBtn_pressed():
	get_tree().paused = false

func _process(delta):
	pass
var index = 0
func changeFocus(dir):
	pass

func _on_QuitBtn_pressed():
	get_tree().quit()