extends CharacterBody2D


const SPEED = 270.0
const JUMP_VELOCITY = -400.0

@onready var dash_duration_timer: Timer = $DashDurationTimer
@onready var cooldown_dash: Timer = $CooldownDash
@onready var dash_effect_timer: Timer = $DashEffectTimer

var direction = 0
var is_dashing = false
var can_dash = true
var dash_speed = 4

func get_direction():
	if not is_dashing:
		direction = Input.get_axis("Left", "Right")

func dash():
	if (Input.is_action_just_pressed("dash") and can_dash and direction != 0):
		is_dashing = true
		can_dash = false
		cooldown_dash.start()
		dash_duration_timer.start()
		dash_effect_timer.start()
	
	if is_dashing:
		velocity.x = direction * SPEED * dash_speed
		velocity.y = 0


func _physics_process(delta: float) -> void:
	add_gravity(delta)
	dash()
	get_direction()
	jump()
	run()





	move_and_slide()

func jump():
		# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func add_gravity(delta):
	# Add the gravity.
	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta

func run():
	if is_dashing:
		return
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func _on_dash_duration_timer_timeout() -> void:
	is_dashing = false
	dash_effect_timer.stop()

func _on_dash_effect_timer_timeout() -> void:
	can_dash = true
