extends Node2D

var disable_all = false
var text_purple
var text_door
var cycle_completed_purple = false
var cycle_completed_door = false

var selected
var selected_position

var item_on_door
var door_is_locked = true

@onready var purple_text = [$textbox/text_purple, $textbox/text_purple2, $textbox/text_purple3]
@onready var unlock_text = [$textbox/text_unlock, $textbox2, $textbox/text_unlock3]

var purple_num = 0
var door_num = 0

var has_key = false

func _ready():
	$textbox.hide()
	$textbox2.hide()
	$selectable.hide()
	text_purple = false
	text_door = false


func _process(delta):
	if disable_all == true:
		$purple.disabled = true
		$cat_poster.disabled = true
		$window.disabled = true
		$scrimblo.disabled = true
		$light.disabled = true
		$door.disabled = true
	elif disable_all == false:
		$purple.disabled = false
		$cat_poster.disabled = false
		$window.disabled = false
		$scrimblo.disabled = false
		$light.disabled = false
		$door.disabled = false
	
	# for dialogue with 1 textbox
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and disable_all == true and text_purple == false and text_door == false:
		$textbox.hide()
		$textbox/text_catposter.hide()
		$textbox/text_window.hide()
		$textbox/text_light.hide()
		$textbox/text_scrimblo.hide()
		$textbox/text_key.hide()
		$textbox/text_door_locked.hide()
		$textbox/text_door_lockedbuthaskey.hide()
		$textbox/text_unlock.hide()
		disable_all = false
		
	# for dialogue with multiple textboxes
	if text_purple:
		if Input.is_action_just_pressed("click"):
			purple_num += 1
			if purple_num >= len(purple_text):
				cycle_completed_purple = true
				purple_num = 0
			if cycle_completed_purple:
				text_purple = false
				disable_all = false
				$textbox.hide()
				$textbox/text_purple3.hide()
			else:
				for i in range(len(purple_text)):
					if i != purple_num:
						purple_text[i].hide()
					else:
						purple_text[i].show()
						
	if text_door:
		if Input.is_action_just_pressed("click"):
			door_num += 1
			if door_num >= len(unlock_text):
				cycle_completed_door = true
				door_num = 0
			if cycle_completed_door:
				text_door = false
				disable_all = false
				$textbox.hide()
				$textbox/text_unlock3.hide()
			else:
				for i in range(len(unlock_text)):
					if i != door_num:
						unlock_text[i].hide()
					else:
						unlock_text[i].show()
	if door_num == 1:
		$textbox.hide()
		$textbox2/text_unlock2.show()
	elif door_num == 2:
		$textbox.show()
		$textbox2.hide()
						
	# inventory item click and drag and use on object
	$mouse_ray.global_position = get_global_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if $mouse_ray.is_colliding() and $mouse_ray.get_collider().get_meta("selectable"):
			selected = $mouse_ray.get_collider()
		
	# do key things
	if selected != null and Input.is_action_just_pressed("click"):
		selected_position = selected.global_position
	elif selected != null and Input.is_action_pressed("click"):
		selected.global_position = $mouse_ray.global_position
	elif selected != null and Input.is_action_just_released("click") and item_on_door == true and door_is_locked == true:
		disable_all = true
		door_is_locked = false
		selected.global_position = selected_position
		selected = null
		cycle_completed_door = false
		text_door = true
		$selectable.queue_free()
		$textbox.show()
		$textbox/text_unlock.show()
	elif selected != null and Input.is_action_just_released("click") and item_on_door == false:
		selected.global_position = selected_position
		selected = null


func _on_purple_pressed():
	disable_all = true
	text_purple = true
	cycle_completed_purple = false
	purple_num = 0
	$textbox.show()
	$textbox/text_purple.show()

func _on_cat_poster_pressed():
	disable_all = true
	$textbox.show()
	$textbox/text_catposter.show()

func _on_window_pressed():
	disable_all = true
	$textbox.show()
	$textbox/text_window.show()

func _on_scrimblo_pressed():
	disable_all = true
	$textbox.show()
	$textbox/text_scrimblo.show()

func _on_light_pressed():
	disable_all = true
	$textbox.show()
	$textbox/text_light.show()
	
func _on_item_key_pressed():
	disable_all = true
	has_key = true
	$item_key.disabled = true
	$textbox.show()
	$textbox/text_key.show()
	$item_key.hide()
	$selectable.show()

func _on_door_pressed():
	if door_is_locked == true:
		if has_key == true:
			disable_all = true
			$textbox.show()
			$textbox/text_door_lockedbuthaskey.show()
		elif has_key == false:
			disable_all = true
			$textbox.show()
			$textbox/text_door_locked.show()
	elif door_is_locked == false:
		get_tree().change_scene_to_file("res://testroom_2.tscn")

func _on_interact_door_mouse_entered():
	item_on_door = true
func _on_interact_door_mouse_exited():
	item_on_door = false
	
	
	
	
#	hi modders
