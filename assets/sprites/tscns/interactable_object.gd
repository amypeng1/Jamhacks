extends Area2D

@onready var interact_label: Label = $Label
@onready var quiz_box: CanvasLayer = $"../Quiz Pop Up"

func _ready() -> void:
	interact_label.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _physics_process(_delta: float) -> void:
	# Check if the player is currently standing in this table's area
	if is_player_nearby():
		# If they hit the Enter key
		if Input.is_action_just_pressed("ui_accept"):
			interact_label.visible = false 
			quiz_box.open_quiz("What colour is Jam Jam?", "Purple", "Vomit Green", "Skid Mark Brown", "Pink Eye Rose", "Purple")

#detection enter
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.current_interactable = self
		interact_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		interact_label.visible = false
		if body.current_interactable == self:
			body.current_interactable = null
			# Close the quiz panel automatically if they walk away from the table

# Helper function to check if this specific table is active in the player's memory
func is_player_nearby() -> bool:
	for body in get_overlapping_bodies():
		if body is CharacterBody2D and body.current_interactable == self:
			return true
	return false
