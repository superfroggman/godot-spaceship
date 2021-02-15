extends RigidBody



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#ROTATION
	var torque = Vector3()
	if Input.is_action_pressed("yaw-"):
		torque.y += 0.01
	if Input.is_action_pressed("yaw+"):
		torque.y -= 0.01
	if Input.is_action_pressed("roll-"):
		torque.x -= 0.01
	if Input.is_action_pressed("roll+"):
		torque.x += 0.01
	if Input.is_action_pressed("pitch-"):
		torque.z -= 0.01
	if Input.is_action_pressed("pitch+"):
		torque.z += 0.01
	
#	torque = torque.normalized().rotated(Vector3.UP, rotation.y)

	add_torque(torque*10)
	
	#MOVEMENT
	var velocity = Vector3()
	if Input.is_action_pressed("moveLeft"):
		velocity.z -= 1
	if Input.is_action_pressed("moveRight"):
		velocity.z += 1
	if Input.is_action_pressed("moveBack"):
		velocity.x -= 1
	if Input.is_action_pressed("moveForward"):
		velocity.x += 1
	if Input.is_action_pressed("moveDown"):
		velocity.y -= 1
	if Input.is_action_pressed("moveUp"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	velocity*=speed
	

	velocity = velocity.normalized().rotated(Vector3.UP, rotation.y).rotated(Vector3.RIGHT, rotation.x).rotated(Vector3.BACK, rotation.z)


	apply_central_impulse(velocity)

