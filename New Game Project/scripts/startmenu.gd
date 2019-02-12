# startmenu.gd
extends Control

func _on_Startgamebutton_pressed():
 	get_tree().change_scene("res://scenes/testworld.tscn")

func _on_quitgamebutton_pressed():
	get_tree().quit()