class_name Player
extends Character

@export var respawn_time: float = 1.0

var start_position: Vector2

const JUMP_VELOCITY: float = -400.0


func _ready() -> void:
	self.start_position = self.global_position


func _physics_process(delta: float) -> void:
	if !self.is_rotating and %Area2DUp.has_overlapping_bodies() and %Area2DDown.has_overlapping_bodies():
		var overlappingBodiesUp: Array[Node2D] = %Area2DUp.get_overlapping_bodies()
		if overlappingBodiesUp[0] is Thwomp:
			var thwomp: Thwomp = overlappingBodiesUp[0] as Thwomp
			if thwomp.is_angry:
				self.die()
		else:
			self.die()

	if !self.can_move:
		move_and_slide()
		return
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: float = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
		%AnimatedSprite2D.play("run")
		
		if direction < 0:
			%AnimatedSprite2D.flip_h = false
		else:
			%AnimatedSprite2D.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		%AnimatedSprite2D.play("idle")

	move_and_slide()
	
	
func die() -> void:
	super.die()
	
	await get_tree().create_timer(self.respawn_time).timeout
	
	self.global_position = self.start_position
	self.velocity = Vector2.ZERO
	self.can_move = true
	self.is_rotating = false
	%AnimatedSprite2D.rotation = 0.0
	await get_tree().create_timer(0.1).timeout # For collisions to work properly, need to wait a bit before re-enabling
	%CollisionShape2D.set_deferred("disabled", false)
	%Area2DUp.monitoring = true
	%Area2DDown.monitoring = true
