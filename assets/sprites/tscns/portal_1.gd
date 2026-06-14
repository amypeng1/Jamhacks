extends Area2D

const TARGET_SCENE = "res://scene/level2.tscn"

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# Verify that the object stepping into the portal is a character body
	if body is CharacterBody2D:
		print("Player hit the portal! Transporting to Level 2...")
		
		# Teleport the player immediately to the target level file
		if Global.ramen_made == true:
			var error = get_tree().change_scene_to_file(TARGET_SCENE)
			if error != OK:
				print("Error: Could not load Level 2 scene. Check your file path string!")
