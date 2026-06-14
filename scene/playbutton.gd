extends TextureButton

const TARGET_SCENE = "res://scene/level1.tscn"

func _pressed() -> void:
	print("Play button clicked! Transporting to Level 1...")
	
	var error = get_tree().change_scene_to_file(TARGET_SCENE)
	if error != OK:
		print("Error: Could not load Level 1 scene. Check your file path string!")
