extends KinematicBody2D

signal action_pressed(body)

const UP = Vector2(0, -1)
const GRAVITY = 40
const SPEED = 400
const MAX_JUMP = -1000
const MIN_JUMP = -150
var motion = Vector2()
var jump_sound

func _ready():
	jump_sound = get_node("jumpsound")
	set_process_input(true)

func _physics_process(delta):
	motion.y += GRAVITY

	#Horizontal movement.
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$Sprite.flip_h = false
		if is_on_floor():
			$Sprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$Sprite.flip_h = true
		if is_on_floor():
			$Sprite.play("run")
	else:
		motion.x = 0
		if is_on_floor():
			$Sprite.play("idle")
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		jump_sound.play()
		motion.y = MAX_JUMP #*2
		$Sprite.play("jump")
	if Input.is_action_just_released("ui_up"):
		motion.y = clamp(motion.y, MIN_JUMP, motion.y)
	
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("action_pressed", self)
	
	motion = move_and_slide(motion, UP)
  
	position.x = clamp(position.x, 0, 4096)
	position.y = clamp(position.y, 0, 2880)
	
	
func _input(event):
	if event.is_action_pressed("ui_up"):
		pass#jump_sound.play()

	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_escape"):
		get_tree().quit()