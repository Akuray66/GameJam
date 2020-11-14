extends KinematicBody2D

export var speed = 1000
var motion = Vector2()

var moving = false
var animPlayer
var movement
var speedMultiplier = 8

func _ready():
	animPlayer = get_node("AnimationPlayer")
	set_physics_process(true)
	
func _physics_process(delta):
		ApplyMovement(delta)
		
func ApplyMovement(deltaTime):
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	if LEFT:
		motion.x -= speed * deltaTime
		moving = true
		CheckMovementLoop()
	elif RIGHT:
		motion.x += speed * deltaTime
		moving = true
		CheckMovementLoop()
	elif UP:
		motion.y -= speed * deltaTime
		moving = true
		CheckMovementLoop()
	elif DOWN:
		motion.y += speed * deltaTime
		moving = true
		CheckMovementLoop()
	elif !LEFT or !RIGHT or !UP or !DOWN:
		moving = false
		CheckMovementLoop()
	
	#Motion calculation
	
 move_and_slide(motion.normalized() * speed * speedMultiplier * deltaTime)
	
func CheckMovementLoop():
	if moving:
		if !motion.is_normalized():
			match motion.normalized():
				Vector2.LEFT:
					movement="LEFT_walk_Z"
					animPlayer.play(movement, -speedMultiplier)
				Vector2.RIGHT:
					movement="RIGHT_Walk_D"
					animPlayer.play(movement, -speedMultiplier)
				Vector2.UP:
					movement="UP_Walk_Z"
					animPlayer.play(movement, -speedMultiplier)
				Vector2.DOWN:
					movement="DOWN_Walk_S"
					animPlayer.play(movement, -speedMultiplier)
				
					
		elif !moving:
			motion.x = 0
			motion.y = 0
			match movement:
				"LEFT_walk_Z":
					animPlayer.play("IDLE")
				"RIGHT_Walk_D":
					animPlayer.play("IDLE")
				"UP_Walk_Z":
					animPlayer.play("IDLE")
				"DOWN_Walk_S":
					animPlayer.play("IDLE")
						
