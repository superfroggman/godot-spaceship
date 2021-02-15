extends RigidBody



# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

var speed = 4
var mouseSensitivity = 0.01

var ground_acceleration = 8
var air_acceleration = 2
var acceleration = ground_acceleration
var jump = 4.5
var gravity = 9.8
var stick_amount = 10
var mouse_sensitivity = 1

var direction = Vector3()
func _input(event):
	if event is InputEventMouseMotion:

		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x*0.01)
			rotate_z(-event.relative.y*0.01)

	direction = Vector3()
	direction.z = -Input.get_action_strength("move_forward") + Input.get_action_strength("move_backward")
	direction.x = -Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
	direction = direction.normalized().rotated(Vector3.UP, rotation.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector3()  # The player's movement vector.

	if Input.is_action_pressed("ui_right"):
		velocity.z += 1
	if Input.is_action_pressed("ui_left"):
		velocity.z -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.x += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	velocity*=speed
	
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity = velocity.normalized().rotated(Vector3.UP, rotation.y)

#	apply_impulse(velocity, Vector3.UP)
	apply_central_impulse(velocity)

