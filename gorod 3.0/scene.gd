extends Node2D

var is_button_on_mouse = false
var is_following = false
var following_house 


@onready var pause_menu = $CanvasLayer/pause_menu

var house_1 = preload("res://test_house.tscn")
var g_house = preload("res://g_house.tscn")
var field_1 = preload("res://field.tscn")
var paused = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func inst_house():
	var instance = house_1.instantiate()
	$Houses.add_child(instance,true)
	print(instance.name)
	Global.houses.append(instance.name)
	following_house = instance

func inst_g_house():
	var instance = g_house.instantiate()
	$Houses.add_child(instance,true)
	print(instance.name)
	Global.houses.append(instance.name)
	following_house = instance


func inst_field():
	var instance = field_1.instantiate()
	$Fields.add_child(instance,true)
	print(instance.name)
	Global.fields.append(instance.name)
	following_house = instance
	
func _on_button_pressed():
	print(Global.is_obj_follow_mouse)
	if !Global.delete_mode:
		if Global.is_obj_follow_mouse == false:
			print("--")
			Global.is_all_fields_blinking = false
			inst_house()
			is_following = true

func _input(event):
	if Global.is_all_fields_blinking:
		$CanvasLayer/TextureRect2.visible = true
	else:
		$CanvasLayer/TextureRect2.visible = false
	
	if event.is_action_pressed("rkm"):
		if Global.is_all_fields_blinking:
			Global.is_all_fields_blinking = false
	
	if event.is_action_pressed("lkm"):
		if is_following == true:
			is_following = false
		if Global.delete_mode == true:
			print("delete")
		
	if event.is_action_pressed("r"):
		if Global.going_with_man == false:
			Global.going_with_man = true
		else:
			Global.going_with_man = false
	if event.is_action_pressed("delete_mode"):
		#if Global.delete_mode:
		#	!Global.delete_mode
		#else:
		if Global.delete_mode:
			Global.delete_mode = false
			$CanvasLayer/TextureRect.visible = false
			#$CanvasLayer/Label.text = "Delete Mode: false"
		else:
			Global.delete_mode = true
			$CanvasLayer/TextureRect.visible = true
			#$CanvasLayer/Label.text = "Delete Mode: true"
		print(Global.delete_mode)

	
	if event.is_action_pressed("esc"):
		pauseMenu()
	
func _on_button_2_pressed():
	if !Global.delete_mode:
		if Global.is_obj_follow_mouse == false:
			Global.is_all_fields_blinking = false
			inst_field()
			is_following = true


func _on_button_mouse_entered():

	is_button_on_mouse = true
	#print(is_button_on_mouse)

func _on_button_mouse_exited():
	is_button_on_mouse = false


func _on_button_2_mouse_entered():

	is_button_on_mouse = true
	#print(is_button_on_mouse)

func _on_button_2_mouse_exited():
	is_button_on_mouse = false



func pauseMenu():
	if paused:
		pause_menu.show()
		get_tree().paused = true
	else:
		pause_menu.hide()
		get_tree().paused = false
		
	paused = !paused


func _on_texture_button_pressed():
	if $CanvasLayer/ScrollContainer.visible == true:
		$CanvasLayer/ScrollContainer.visible = false
	else:
		$CanvasLayer/ScrollContainer.visible = true


func _on_texture_button_2_pressed():
	if $CanvasLayer/ScrollContainer2.visible == true:
		$CanvasLayer/ScrollContainer2.visible = false
	else:
		$CanvasLayer/ScrollContainer2.visible = true
	
		


func _on_button_3_pressed():
	if !Global.delete_mode:
		if Global.is_obj_follow_mouse == false:
			Global.is_all_fields_blinking = false
			inst_g_house()
			is_following = true
