extends KinematicBody2D

export var MAX_SPEED = 500
export var DEFAULT_SPEED = 200
export var DEFAULT_JUMP_HEIGHT = -550

export var JUMP_SOUND = 10

var motion = Vector2()

var current_speed = DEFAULT_SPEED
var current_jump_height = DEFAULT_JUMP_HEIGHT

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_up"):
		motion.y += current_jump_height
	if Input.is_action_pressed("ui_right"):
		motion.x += current_speed
	if Input.is_action_pressed("ui_left"):
		motion.x -= current_speed
	
	pass