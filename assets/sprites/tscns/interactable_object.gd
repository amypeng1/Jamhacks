extends Area2D

# Reference to the QuizPopup node in your level scene tree
@onready var quiz_box: CanvasLayer = $"../Quiz Pop Up"

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _physics_process(_delta: float) -> void:
	# Check if the player is currently standing in this table's area
	if is_player_nearby():
		# If they hit the Enter key
		if Input.is_action_just_pressed("ui_accept"):
			# Pop up the full quiz layout with your custom question!
			quiz_box.open_quiz()

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.current_interactable = self

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.current_interactable == self:
			body.current_interactable = null
			# Close the quiz panel automatically if they walk away from the table
			quiz_box.close_quiz()

# Helper function to check if this specific table is active in the player's memory
func is_player_nearby() -> bool:
	for body in get_overlapping_bodies():
		if body is CharacterBody2D and body.current_interactable == self:
			return true
	return false
