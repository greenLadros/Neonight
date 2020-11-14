extends KinematicBody2D


# global vars
onready var sprite = get_node("Sprite")
onready var timer = get_node("Timer")
var motion = Vector2(0,0)
const SPEED = 200
const JUMP = 7500
const GRAVITY = 200
const UP = Vector2(0,-1)
var ON_FLOOR = true
var PASSED_LIMIT = false
var DEBOUNCE = false
var HEALTH = 25

#signals
signal hurt

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play("Idle")
	##connect
	var GUINode = get_tree().get_root().get_node("NeonField/GameState")
	connect("hurt",GUINode,"updateHealth")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	applyGravity(delta)
	limit(delta) ### not sure if working
	move()

func move():
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left") and PASSED_LIMIT==false:
		#move right
		motion.x = SPEED
		#animate
		sprite.flip_h = false
		sprite.play("Run")
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right") and PASSED_LIMIT==false:
		#move left
		motion.x = -SPEED
		#animate
		sprite.flip_h = true
		sprite.play("Run")
	elif Input.is_action_pressed("up") and not Input.is_action_pressed("down") and PASSED_LIMIT==false and DEBOUNCE==false: #and ON_FLOOR==true  #and not Input.is_action_pressed("left") and not Input.is_action_pressed("right")
		#JUMP
		motion.y = -JUMP
		DEBOUNCE = true
		timer.start(0.3)
		#animate
		#######################sprite.play('Jump')
	elif Input.is_action_pressed("down") and not Input.is_action_pressed("up") and PASSED_LIMIT==false: #and ON_FLOOR==true  #and not Input.is_action_pressed("left") and not Input.is_action_pressed("right")
		#CROUCH
		pass
		#animate
	elif Input.is_action_pressed("MBL") and PASSED_LIMIT==false:
		#SHOOT
		pass
		#animate 
	elif Input.is_action_just_pressed("up") and (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and PASSED_LIMIT==false and DEBOUNCE==false:
		motion.x = 0
		motion.y = -JUMP
	else:
		motion.x = 0
		motion.y = 0
		sprite.play("Idle")
	move_and_slide(motion, UP)
	ON_FLOOR = is_on_floor()

func applyGravity(delta):
		#apply gravity
	if is_on_floor():
		motion.y = 0
	else:
		motion.y = GRAVITY
	move_and_slide(motion)

func limit(delta):
	#check for speed and height limits
	if sprite.get_global_position().y < 64:
		PASSED_LIMIT = true
	else:
		PASSED_LIMIT = false


func _on_Timer_timeout():
	DEBOUNCE = false

func hurt(dmg):
	print("man")
	HEALTH -= dmg
	emit_signal("hurt", HEALTH)
	if HEALTH <= 0:
		#change to game over scene
		get_tree().change_scene("res://Scenes/UI/Gameover.tscn")
	
