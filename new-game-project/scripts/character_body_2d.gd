extends CharacterBody2D


var SPEED = 200.0
const JUMP_VELOCITY = -320.0

var can_dash : bool = true
var is_dashing : bool = false
var dash_jump = 1

@onready var dash_cooldown : Timer = $Timer

func _physics_process(delta: float) -> void:
	
	
	

	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 0.9


	
	if is_on_floor():
		dash_jump = 1
		is_dashing = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif is_dashing and dash_jump > 0:
			velocity.y = JUMP_VELOCITY
			dash_jump -= 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("dash") and can_dash:
		$Dashtimer.start()
		SPEED *= 5
		is_dashing = true
		can_dash = false
		
		
		
		if direction > 0:
			velocity.x = direction * SPEED
		elif direction < 0:
			velocity.x = direction * SPEED
		elif direction == 0:
			velocity.y = JUMP_VELOCITY * 1.3
		$CooldownDash.start()
	

	move_and_slide()


func _on_dashtimer_timeout() -> void:
	
	SPEED = 200.0


func _on_cooldown_dash_timeout() -> void:
	can_dash = true
