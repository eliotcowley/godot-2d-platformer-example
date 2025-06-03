class_name Character
extends CharacterBody2D

@export var mass: float = 10.0
@export var speed: float = 300.0
@export var die_velocity: float = -100.0
@export var die_rotation: float = 0.1

@export var collision_shape: CollisionShape2D
@export var animated_sprite: AnimatedSprite2D

var can_move: bool = true
var is_rotating: bool = false


func _physics_process(delta: float) -> void:
	# Add the gravity
	if not self.is_on_floor():
		self.velocity += self.get_gravity() * self.mass
	
	# Rotate sprite when dying
	if self.is_rotating:
		self.animated_sprite.rotate(self.die_rotation)


func die() -> void:
	self.collision_shape.set_deferred("disabled", true)
	await get_tree().create_timer(0.01).timeout # For collisions to work properly, need to wait a bit before re-enabling
	self.velocity.x = 0.0
	self.velocity.y = self.die_velocity
	self.can_move = false
	self.is_rotating = true
