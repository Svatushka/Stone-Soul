extends KinematicBody2D

const GRAVITY = Vector2(0, 2000)
const SPEED = 200
const JUMP_HEIGHT = -600
const ATTACK_DISTANCE = 50

var velocity = Vector2()
var is_attacking = false

func _physics_process(delta):
	var input_vector = Vector2()
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector = input_vector.normalized()

	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_HEIGHT
	else:
		velocity += GRAVITY * delta

	if Input.is_action_just_pressed("attack"):
		is_attacking = true

	if is_attacking:
		if $AttackArea.is_colliding():
			$AttackArea.get_collider().queue_free()
			is_attacking = false
		else:
			$AttackArea.position.x += SPEED * delta

	velocity.x = input_vector.x * SPEED
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_AttackArea_body_entered(body):
	if body.is_in_group("enemies"):
		body.queue_free()
