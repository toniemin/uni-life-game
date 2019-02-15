extends CanvasLayer

# Number of buttons in the main menu.
const NUM_OF_BTN = 3
# Scene opened from StartButton.
const NEXT_SCENE = "res://scenes/testworld (2).tscn"
# Text displayed when "Instructions"-button is pressed.
const HELP_TEXT = "ARROW_LEFT/A == GO LEFT\nARROW_RIGHT/D == GO RIGHT\n SPACEBAR == JUMP/ACTION"

func _ready():
	showMainMenu()
	$HelpText.text = HELP_TEXT
	# Connect signal handlers.
	$StartButton.connect("pressed", self, "_on_StartButton_pressed")
	$HelpButton.connect("pressed", self, "_on_HelpButton_pressed")
	$QuitButton.connect("pressed", self, "_on_QuitButton_pressed")
	$BackButton.connect("pressed", self, "_on_BackButton_pressed")
	

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		changeFocus(-1)
	if Input.is_action_just_pressed("ui_down"):
		changeFocus(1)

# Draw the main buttons on the screen and hide HelpMenu buttons/text.
func showMainMenu():
	get_tree().call_group("HelpMenu", "hide")
	get_tree().call_group("MainButtons", "show")
	$StartButton.grab_focus()
	index = 0

# Keep track of focused button.
var index = 0
# With help of index, keep track of which buttons should be focused.
# Index has values in the range [0, NUM_OF_BTN-1].
func changeFocus(direction):
	index = clamp(index+direction, 0, NUM_OF_BTN-1)
	if $BackButton.has_focus():
		return
	
	if index == 0:
		$StartButton.grab_focus()
	elif index == 1:
		$HelpButton.grab_focus()
	elif index == 2:
		$QuitButton.grab_focus()
	

# Handler for StartButton. Switch to game scene.
func _on_StartButton_pressed():
	get_tree().change_scene(NEXT_SCENE)

# Handler for HelpButton. Hides main buttons and
# draws playing instructions on the screen.
func _on_HelpButton_pressed():
	get_tree().call_group("MainButtons", "hide")
	get_tree().call_group("HelpMenu", "show")
	$BackButton.grab_focus()
	
# Handler for ScoreButton.
# TODO: Show scoreboard.
func _on_ScoreButton_pressed():
	pass
	
# Handler for QuitButton. Close the game.
func _on_QuitButton_pressed():
	get_tree().quit()
	
# Exit help menu.
# TODO: Exit scoreboard.
func _on_BackButton_pressed():
	showMainMenu()