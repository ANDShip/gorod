extends Area2D


var possible_to_work = false
var is_field_blink = false
var field_nummer 
var is_someone_working = false
var is_follow = true
var is_place_free = true
var entered_obj = 0
var field_gold = 0
var possible_to_information = false
@onready var nav_region = get_node("/root/scene/region")
@onready var container = get_node("/root/scene/CanvasLayer/ScrollContainer/VBoxContainer")
@onready var man
var possible_to_delete = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.is_obj_follow_mouse = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_someone_working:
		work()
	if Global.is_all_fields_blinking:
		blink()
	else:
		$Sprite2D3.visible = false
	if is_field_blink:
		if possible_to_work:
			if $Sprite2D3.visible:
				if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
					if Global.path_from_worker:
						$Sprite2D3.visible = false
						Global.is_all_fields_blinking = false
						man = get_node(Global.path_from_worker)
						print("-------     ", man," - - - - ",Global.path_from_worker)
						man.target_position = global_position
	if is_follow:
		position = get_global_mouse_position()
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			if entered_obj == 0:
				
				if Global.money >= 100:
					Global.money -= 100
					is_follow = false
					print("kaka")
					$Sprite2D2.visible = true
					Global.is_obj_follow_mouse = false
					Global.fields_count += 1
					add_polygon()
					creating_button()
					
					
					
				else:
					print("no money")
			else:
				print("zanyato")
		
		if Input.is_action_just_pressed("rotate_left"):
			rotation -= deg_to_rad(45)
			print(delta)
		if Input.is_action_just_pressed("rotate_right"):
			rotation += deg_to_rad(45)
			print(rotation)
			
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			queue_free()
	if Global.delete_mode == true:
		if possible_to_delete == true:
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				#container.
				queue_free()


func _on_area_entered(area):
	entered_obj += 1


func _on_area_exited(area):
	entered_obj -= 1


func _on_mouse_entered():
	possible_to_delete = true
	#$Sprite2D3.visible = true
	possible_to_information = true
	possible_to_work = true


func _on_mouse_exited():
	possible_to_delete = false
	#$Sprite2D3.visible = false
	possible_to_information = false
	#sprite.visible = false
	possible_to_work = false

func _on_body_entered(body):
	is_someone_working = true
	print("name of man ",body.name)
	$Timer.start()

func _on_body_exited(body):
	is_someone_working = false
	$Timer.stop()

func work():
	if field_gold != 0:
		Global.money += field_gold
		field_gold -= field_gold
	
	#print(field_gold)

func _on_timer_timeout():
	field_gold += 100



func _button_pressed():
	
	print("op")
	man.target_position = position


func creating_button():
	var n = Global.fields_count
	field_nummer = n
	var AddButton = Button.new()
	AddButton.set_script(load("res://field_button_in_ui.gd"))
	AddButton.pressed.connect(self._button_pressed)
	container.add_child(AddButton)
	AddButton.set_name("FieldButton" + str([n]))
	AddButton.set_text("Field " + str([n]))
	AddButton.add_theme_font_size_override("font_size", 32)
	
	
	
	
func blink():
	
	$Sprite2D3.visible = true
	is_field_blink = true



func add_polygon():
	var new_polygon : PackedVector2Array
	var polygon_transform = get_node("Polygon2D").get_global_transform()
	var polygon_bp = get_node("Polygon2D").get_polygon()
	print(polygon_bp)
	for vertex in polygon_bp:
		
		new_polygon.append((polygon_transform * vertex))
		#$Polygon2D.get_polygon()
	nav_region.get_navigation_polygon().add_outline(new_polygon)
	nav_region.get_navigation_polygon().make_polygons_from_outlines()
	print(nav_region.get_navigation_polygon().get_polygon_count())
