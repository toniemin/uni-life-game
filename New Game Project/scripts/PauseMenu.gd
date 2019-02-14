extends CanvasLayer

# Number of buttons in the pause menu.
const NUM_OF_BTN = 2
# Keeps track of focused button.
var index = 0

func _ready():
	$Panel.hide()
	$Panel/ContinueBtn.connect("pressed", self, "_on_ContinueBtn_pressed")
	$Panel/QuitBtn.connect("pressed", self, "_on_QuitBtn_pressed")

func _process(delta):
	if Input.is_action_just_pressed("ui_escape"):
		pass
	if Input.is_action_just_pressed("ui_up"):
		changeFocus(-1)
	if Input.is_action_just_pressed("ui_down"):
		changeFocus(1)

func changeFocus(direction):
	index = clamp(index+direction, 0, NUM_OF_BTN-1)
	
	if index == 0:
		$Panel/ContinueBtn.grab_focus()
	elif index == 1:
		$Panel/QuitBtn.grab_focus()
	
func toggleMenu():
	if hidden():
		get_tree().paused = true
		Panel.show()
		$Panel/ContinueBtn.get_focus()
	else:
		$Panel.hide()
		$Panel.release_focus()
		get_tree().pause = false
		
func _on_ContinueBtn_pressed():
	toggleMenu()

func _on_QuitBtn_pressed():
	get_tree().quit()