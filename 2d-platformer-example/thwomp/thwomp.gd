class_name Thwomp
extends AnimatableBody2D

@export var fall_speed: float = 1.0
@export var fall_timer: float = 1.0
@export var rise_speed: float = 1.0

var is_angry: bool = false
var is_rising: bool = false
var start_position: Vector2


func _ready() -> void:
	self.start_position = self.global_position


func _physics_process(_delta: float) -> void:
	if self.is_angry:
		self.move_and_collide(Vector2.DOWN * self.fall_speed)
	else:
		if %RayCast2D.is_colliding():
			# Detected player
			self.is_angry = true
			self.is_rising = false
			%AnimatedSprite2D.play("angry")
			get_tree().create_timer(self.fall_timer).timeout.connect(on_fall_timer_timeout)
	
	if self.is_rising:
		self.global_position.y -= self.rise_speed
		if self.global_position.y <= self.start_position.y:
			self.is_rising = false


func on_fall_timer_timeout():
	%AnimatedSprite2D.play("idle")
	self.is_angry = false
	self.is_rising = true
