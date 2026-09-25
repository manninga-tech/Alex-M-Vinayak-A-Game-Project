extends CharacterBody2D


var SPEED = 100.0
const JUMP_VELOCITY = -220.0

var can_dash : bool = true
var is_dashing : bool = false

@onready var dash_cooldown : Timer = $Timer

func _physics_process(delta: float) -> void:
	
	
	

	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_floor():
		is_dashing = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor() or is_dashing == true:
			velocity.y = JUMP_VELOCITY

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
		
		if direction > 0:
			velocity.x = direction * SPEED
		elif direction < 0:
			velocity.x = direction * SPEED
		elif direction == 0:
			velocity.y = JUMP_VELOCITY * 1
		
	

	move_and_slide()


func _on_dashtimer_timeout() -> void:
	
	SPEED = 100.0
