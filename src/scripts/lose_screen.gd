extends CanvasLayer



func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/game_new.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/main_menu.tscn")
