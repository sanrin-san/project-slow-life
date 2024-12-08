extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 100

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()

	# アニメーション更新
	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				animated_sprite_2d.play("walk_right")
				player.player_direction = Vector2.RIGHT
			else:
				animated_sprite_2d.play("walk_left")
				player.player_direction = Vector2.LEFT
		else:
			if direction.y > 0:
				animated_sprite_2d.play("walk_front")
				player.player_direction = Vector2.DOWN
			else:
				animated_sprite_2d.play("walk_back")
				player.player_direction = Vector2.UP
	else:
		animated_sprite_2d.stop()

	# プレイヤーの移動更新
	player.velocity = direction * speed
	player.move_and_slide()


func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
