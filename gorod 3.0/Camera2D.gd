extends Camera2D
var fixed_toggle_point = Vector2(0,0)
var zoom_speed = 0.1

var currently_moving_map = false
var moving = false
var mouse_start
var camera_start

func _input(event):
	pass
	if event.is_action_released("wheel_up"):
		zoom()
	if event.is_action_released("wheel_down"):
		zoom()

func zoom():
	if Input.is_action_just_released('wheel_down'):
		set_zoom(get_zoom() - Vector2(0.25, 0.25))
	if Input.is_action_just_released('wheel_up'): #and get_zoom() > Vector2.ONE:
		set_zoom(get_zoom() + Vector2(0.25, 0.25))


#func _process(delta):
#	# This happens once 'move_map' is pressed
#	if Input.is_action_just_pressed('move_map'):
#		var ref = get_viewport().get_mouse_position()
#		fixed_toggle_point = ref
#	# This happens while 'move_map' is pressed
#	if Input.is_action_pressed('move_map'):
#		slide_map_around()


func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		# This happens once 'move_map' is pressed
		if( !currently_moving_map ):
			var ref = get_viewport().get_mouse_position()
			fixed_toggle_point = ref
			currently_moving_map = true
		# This happens while 'move_map' is pressed
		move_map_around()
	else:
		currently_moving_map = false

# this stays the same
func move_map_around():
	var ref = get_viewport().get_mouse_position()
	self.position.x -= (ref.x - fixed_toggle_point.x)/get_zoom().x
	self.position.y -= (ref.y - fixed_toggle_point.y)/get_zoom().y
	fixed_toggle_point = ref
