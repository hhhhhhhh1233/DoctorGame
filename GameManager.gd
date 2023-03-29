extends Node


func _on_restart_button_button_down():
	get_tree().reload_current_scene()

func _on_quit_button_button_down():
	get_tree().quit()
