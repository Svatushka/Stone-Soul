extends KinematicBody2D

const speed = 40
const JumpVelocity = 50
const gravity = 200
const Up = Vector2(0, -1)
var Health = 100
var Movement = Vector2()

func _physics_process(delta):
	
	Movement = move_and_slide_with_snap(Movement, Up)
	
	pass

func _process(delta):
	
	Movement.y += gravity
	pass
func Keyboard():
	
	if Input.is_action_pressed("move_left"):
		Movement.x -= speed
		$Sprite.play("Run")
		$Sprite.flip_h = true
	elif Input.is_action_pressed("move_right"):
		Movement.x += speed
		$Sprite.play("Run")
		$Sprite.flip_h = false
	else:
		Movement.x = 0
		$Sprite.play("Idel")
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			Movement.y = -JumpVelocity
	else:
		$Sprite.play("Jump")
	pass
