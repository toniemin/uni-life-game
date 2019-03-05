extends KinematicBody2D

signal action_pressed(body)

const UP = Vector2(0, -1)
const GRAVITY = 40
const SPEED = 400
const MAX_JUMP = -1000
const MIN_JUMP = -150
var motion = Vector2()

var soundPlayer
var jump_sounds

export (int) var clamp_x
export (int) var clamp_y

func play_jump_sound():
	soundPlayer.set_stream(jump_sounds[randi() % jump_sounds.size()-1])
	soundPlayer.play()
	

func _init():
	jump_sounds = []
	var dir = Directory.new()
	dir.open("res://Sounds and music/jump/")
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and not file.ends_with(".import"):
			var audioFile = load(dir.get_current_dir() + '/'+ file)
			jump_sounds.append(audioFile)
	
	dir.list_dir_end()

func _ready():
	soundPlayer = get_node("jumpsound")
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
		play_jump_sound()
		motion.y = MAX_JUMP
		$Sprite.play("jump")
	if Input.is_action_just_released("ui_up"):
		motion.y = clamp(motion.y, MIN_JUMP, motion.y)
	
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("action_pressed", self)
	
	motion = move_and_slide(motion, UP)
  
	# Limit player movement to level
	position.x = clamp(position.x, 0, clamp_x)
	position.y = clamp(position.y, 0, clamp_y)
	
	# Limit camera movement to level size
	var camera = get_node("Camera2D")
	camera.limit_right = clamp_x
	camera.limit_bottom = clamp_y
	
func _process(delta):
	if Input.is_action_just_pressed("ui_escape"):
		get_tree().quit()