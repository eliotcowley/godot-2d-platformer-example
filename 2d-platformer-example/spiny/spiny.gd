extends CharacterBody2D

@export var speed: float = 1.0

var direction: float = -1.0


func _physics_process(delta: float) -> void:
	if %RayCast2DRight.is_colliding():
		direction = -1.0
		%AnimatedSprite2D.flip_h = false
	elif %RayCast2DLeft.is_colliding():
		direction = 1.0
		%AnimatedSprite2D.flip_h = true
	
	self.velocity.x = direction * self.speed
	self.velocity.y = get_gravity().y
	self.move_and_slide()
