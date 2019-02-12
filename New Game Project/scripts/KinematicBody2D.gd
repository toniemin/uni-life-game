extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -550
var motion = Vector2()
var jump_sound

func _physics_process(delta):
	motion.y += GRAVITY

	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$Sprite.flip_h = false
		$Sprite.play("walk")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$Sprite.flip_h = true
		$Sprite.play("walk")
	else:
		motion.x = 0
		$Sprite.play("idle")
	if is_on_floor():
		
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	else: 
		$Sprite.play("jump")
	motion = move_and_slide(motion, UP)
	
func _ready():
	jump_sound = get_node("jumpsound")
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("ui_up"):
		jump_sound.play()
	

	pass