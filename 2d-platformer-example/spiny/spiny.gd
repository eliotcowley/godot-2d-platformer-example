extends Character

var direction: float = -1.0
var hiding: bool = false


func _physics_process(_delta: float) -> void:
	if hiding:
		self.velocity.x = 0.0
	else:
		self.velocity.x = direction * self.speed

	self.move_and_slide()


func _on_spike_body_entered(body: Node2D) -> void:
	var player: Player = body as Player
	player.die()


func _on_hide_zones_hide() -> void:
	%AnimatedSprite2D.play("hide")
	self.hiding = true


func _on_hide_zones_unhide() -> void:
	%AnimatedSprite2D.play("move")
	self.hiding = false


func _on_turning_left_collided() -> void:
	direction = 1
	%AnimatedSprite2D.flip_h = true


func _on_turning_right_collided() -> void:
	direction = -1
	%AnimatedSprite2D.flip_h = false
