extends CanvasLayer

func _ready() -> void:
	# Hide the quiz box by default when the level starts
	visible = false

# Show the box and set the text
func open_quiz() -> void:
	visible = true

# Hide the box when the player leaves
func close_quiz() -> void:
	visible = false
