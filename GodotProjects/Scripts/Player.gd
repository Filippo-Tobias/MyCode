extends KinematicBody2D

var velocity = Vector2(0,0)
var Ivelocity = Vector2(0,0)
var speed = 500
var jumpAmounts = 5
var jumpforce = -900
var ABSvelocity = Vector2(0,0)
const GRAVITY = 30
var touchFloor = false
var direction = 0

func _physics_process(_delta):
	ABSvelocity = velocity.abs()
	Ivelocity = velocity.round()
	
	######################################################
	#MFKIN MOVEMENT
	if Input.is_action_just_pressed("right"):
		direction = 1
	if Input.is_action_just_pressed("left"):
		direction = -1
	
	if Input.is_action_just_released("right") and direction == 1:
		direction = 0
	if Input.is_action_just_released("left") and direction == -1:
		direction = 0
	
	if Input.is_action_just_released("right") and Input.is_action_pressed("left"):
		direction = -1
	if Input.is_action_just_released("left") and Input.is_action_pressed("right"):
		direction = 1
	
	velocity.x  = speed * direction
	
	###################################################
	#START OF MOVEMENT AND JUMP BOOST SCRIPT
#	if Input.is_action_pressed("right"):
#		velocity.x = speed
#
#	if Input.is_action_pressed("left"):
#		velocity.x = -speed

	if Input.is_action_pressed("jump") and jumpAmounts > 0:
		jumpAmounts = jumpAmounts - 1
		velocity.y = jumpforce
	if is_on_floor():
		if touchFloor == false:
			jumpAmounts = jumpAmounts + 1
		touchFloor = true
	else:
		touchFloor = false
	#END OF MOVEMENT AND JUMP BOOST SCRIPT
	###################################################
	
	velocity.y = velocity.y + GRAVITY
	print(Ivelocity)
	velocity.x = lerp(velocity.x,0,0.3)
	
	velocity = move_and_slide(velocity,Vector2.UP)
