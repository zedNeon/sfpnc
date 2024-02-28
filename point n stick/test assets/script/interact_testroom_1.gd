extends Node2D

var disable_all = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$textbox.hide()


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
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and disable_all == true:
		disable_all = false
		$textbox.hide()
		$textbox/text_purple.hide()
		$textbox/text_catposter.hide()
		$textbox/text_window.hide()
		$textbox/text_scrimblo.hide()
		$textbox/text_light.hide()

func _on_purple_pressed():
	disable_all = true
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
