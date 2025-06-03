extends Node2D

@export var ray_cast_left: RayCast2D
@export var ray_cast_right: RayCast2D

signal left_collided
signal right_collided


func _physics_process(_delta: float) -> void:
	if ray_cast_left.is_colliding():
		left_collided.emit()
		
	if ray_cast_right.is_colliding():
		right_collided.emit()
