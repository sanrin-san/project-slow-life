class_name GameInputEvents

# static var direction: Vector2

static func movement_input() -> Vector2:
	# 入力を個別に確認し、それを合成して方向ベクトルを取得
	var direction: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("walk_left"):
		direction.x -= 1
	if Input.is_action_pressed("walk_right"):
		direction.x += 1
	if Input.is_action_pressed("walk_up"):
		direction.y -= 1
	if Input.is_action_pressed("walk_down"):
		direction.y += 1

	return direction.normalized() # 正規化して速度が一定になるようにする
	
static func is_movement_input() -> bool:
	return movement_input() != Vector2.ZERO

static func use_tool() -> bool:
	return Input.is_action_just_pressed("hit")
