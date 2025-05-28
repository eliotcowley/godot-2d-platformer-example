extends Node2D

signal left_collided
signal right_collided


func _physics_process(delta: float) -> void:
	if %RayCast2DLeft.is_colliding():
		left_collided.emit()
		
	if %RayCast2DRight.is_colliding():
		right_collided.emit()
