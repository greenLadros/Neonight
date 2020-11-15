extends Control

func _on_Restart_pressed():
	get_tree().change_scene("res://Scenes/Levels/NeonField.tscn")


func _on_Quit_pressed():
	get_tree().quit()
