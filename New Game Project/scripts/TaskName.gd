extends Label

func updateScore(score):
	self.text = "Credits: " + String(score)
	print('score updated')

func _ready():
	add_to_group("timer")
	updateScore(0)