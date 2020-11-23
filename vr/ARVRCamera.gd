extends ARVRCamera


export (float, 0.0, 1.0) var sensitivity = 0.2
var smoothness = 0.5
export (int, 0, 360) var yaw_limit = 360
export (int, 0, 360) var pitch_limit = 360

export (float, 0.0, 1.0) var acceleration = 1.0
export (float, 0.0, 0.0, 1.0) var deceleration = 0.1
export var max_speed = Vector3(5.0, 5.0, 5.0)

export var rotate_left_action = ""
export var rotate_right_action = ""
export var rotate_up_action = ""
export var rotate_down_action = ""
export var forward_action = "ui_up"
export var backward_action = "ui_down"
export var left_action = "ui_left"
export var right_action = "ui_right"
export var up_action = "ui_page_up"
export var down_action = "ui_page_down"



var _mouse_offset = Vector2()
var _rotation_offset = Vector2()
var _yaw = 0.0
var _pitch = 0.0
var _total_yaw = 0.0
var _total_pitch = 0.0

var _direction = Vector3(0.0, 0.0, 0.0)
var _speed = Vector3(0.0, 0.0, 0.0)

const ROTATION_MULTIPLIER = 500

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_process_input(true)
	set_physics_process(false)
	set_process(true)
	translation.y = 1.85


func _input(event):
	if event is InputEventMouseMotion:
		_mouse_offset = event.relative
		
	_rotation_offset.x = Input.get_action_strength(rotate_right_action) - Input.get_action_strength(rotate_left_action)
	_rotation_offset.y = Input.get_action_strength(rotate_down_action) - Input.get_action_strength(rotate_up_action)
	_direction.x = Input.get_action_strength(right_action) - Input.get_action_strength(left_action)
	_direction.y = Input.get_action_strength(up_action) - Input.get_action_strength(down_action)
	_direction.z = Input.get_action_strength(backward_action) - Input.get_action_strength(forward_action)
	
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta):
	var offset = max_speed * acceleration * _direction
	_speed.x = clamp(_speed.x + offset.x, -max_speed.x, max_speed.x)
	_speed.y = clamp(_speed.y + offset.y, -max_speed.y, max_speed.y)
	_speed.z = clamp(_speed.z + offset.z, -max_speed.z, max_speed.z)
	if _direction.x == 0:
		_speed.x *= (1.0 - deceleration)
	if _direction.y == 0:
		_speed.y *= (1.0 - deceleration)
	if _direction.z == 0:
		_speed.z *= (1.0 - deceleration)
	translate(_speed * delta)

	offset = Vector2();
	offset += _mouse_offset * sensitivity
	_mouse_offset = Vector2()
	_yaw = _yaw * smoothness + offset.x * (1.0 - smoothness)
	_pitch = _pitch * smoothness + offset.y * (1.0 - smoothness)
	if yaw_limit < 360:
		_yaw = clamp(_yaw, -yaw_limit - _total_yaw, yaw_limit - _total_yaw)
	if pitch_limit < 360:
		_pitch = clamp(_pitch, -pitch_limit - _total_pitch, pitch_limit - _total_pitch)
	_total_yaw += _yaw
	_total_pitch += _pitch
	rotate_y(deg2rad(-_yaw))
	rotate_object_local(Vector3(1,0,0), deg2rad(-_pitch))









