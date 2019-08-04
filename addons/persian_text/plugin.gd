tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("persian", "res://addons/persian_text/persian_set.gd")
	pass

func _exit_tree():
	remove_autoload_singleton("persian")
	pass
