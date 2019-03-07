extends Label

func updateScore(score):
	self.text = "Credits: " + String(score)

func _ready():
	updateScore(0)