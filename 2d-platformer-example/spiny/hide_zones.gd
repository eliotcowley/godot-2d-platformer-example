extends Area2D

signal hide
signal unhide


func _on_body_entered(_body: Node2D) -> void:
	hide.emit()


func _on_body_exited(_body: Node2D) -> void:
	unhide.emit()
