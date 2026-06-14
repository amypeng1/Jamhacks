extends CharacterBody2D
@onready var sprite = $AnimatedSprite2D 
var a = 0

const SPEED = 100.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			sprite.play("runRight")
			a = 1
		else:
			sprite.play("runLeft")
			a = -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if a == 1:
			sprite.play("right")
		else:
			sprite.play("left")
	move_and_slide()
