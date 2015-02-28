
extends Label

var callback_object
var callback_func
var callback_data

func _ready():
	set_ignore_mouse(false)
		
func _input_event(var event):

	if (event.type == InputEvent.MOUSE_BUTTON &&
	   event.button_index == 1 && event.is_pressed()): 
		callback_object.call(callback_func, callback_data)

func set_selected_callback(var owner, var func_ptr, var data):
	callback_object = owner
	callback_func = func_ptr
	callback_data = data
	