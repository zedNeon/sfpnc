extends Node2D

var disable_all = false
var text_purple
var cycle_completed = false

var selected
var selected_position

@onready var purple_text = [$textbox/text_purple, $textbox/text_purple2, $textbox/text_purple3]
var purple_num = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$textbox.hide()
	$selectable/hud_item_key.hide()
	text_purple = false
#	selected_position = selected.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if disable_all == true:
		$purple.disabled = true
		$cat_poster.disabled = true
		$window.disabled = true
		$scrimblo.disabled = true
		$light.disabled = true
	elif disable_all == false:
		$purple.disabled = false
		$cat_poster.disabled = false
		$window.disabled = false
		$scrimblo.disabled = false
		$light.disabled = false
	
	# for dialogue with 1 textbox
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and disable_all == true and text_purple == false:
		$textbox.hide()
		$textbox/text_catposter.hide()
		$textbox/text_window.hide()
		$textbox/text_light.hide()
		$textbox/text_scrimblo.hide()
		$textbox/text_key.hide()
		disable_all = false
		
	if text_purple:
		if Input.is_action_just_pressed("click"):
			purple_num += 1
			if purple_num >= len(purple_text):
				cycle_completed = true
				purple_num = 0
			if cycle_completed:
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
						
	$mouse_ray.global_position = get_global_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if $mouse_ray.is_colliding() and $mouse_ray.get_collider().get_meta("selectable"):
			selected = $mouse_ray.get_collider()
		
	if selected != null and Input.is_action_just_pressed("click"):
		selected_position = selected.global_position
	elif selected != null and Input.is_action_pressed("click"):
		selected.global_position = $mouse_ray.global_position
	elif selected != null and Input.is_action_just_released("click"):
		selected.global_position = selected_position
		selected = null


func _on_purple_pressed():
	disable_all = true
	text_purple = true
	cycle_completed = false
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
	$item_key.disabled = true
	$textbox.show()
	$textbox/text_key.show()
	$item_key.hide()
	$selectable/hud_item_key.show()
