extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D 
var a = 0
var current_interactable: Area2D = null
const SPEED = 100.0

func _physics_process(_delta: float) -> void:
	# 1. Get input for both horizontal (Left/Right) and vertical (Up/Down) movement
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down") # Or your custom up/down keys
	
	# Normalize ensures diagonal movement isn't accidentally faster
	input_vector = input_vector.normalized()

	# 2. Apply movement velocity
	if input_vector != Vector2.ZERO:
		velocity = input_vector * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	# 3. Handle Animations based on direction
	if input_vector.x > 0:
		sprite.play("runRight")
		a = 1
	elif input_vector.x < 0:
		sprite.play("runLeft")
		a = -1
	elif input_vector.y < 0:
		# If moving up or down, keep playing an animation or use a default
		sprite.play("back") 
	elif input_vector == Vector2.ZERO:
		if a >= 0:
			sprite.play ("default")
		else:
			sprite.play("left")

	# 4. Move the physics body
	move_and_slide()
