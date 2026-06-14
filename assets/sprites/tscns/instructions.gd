extends CanvasLayer 
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dismiss_instructions()

func dismiss_instructions() -> void:
	print("Screen clicked! Removing instruction overlay panel.")
	
	visible = false
