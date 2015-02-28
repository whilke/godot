
extends Node2D

const select_label = preload("res://scripts/baseTypes/select_label.gd")
const choice_offset = 20
const choice_y_pos = -120
const choice_x_pos = -240

var callback_obj
var callback_func

var chat_dlg_node
var choice_container
var choice_pos = 0

func set_chat_node(var chat_node):
	chat_dlg_node = chat_node
	
func _ready():
	choice_container = get_node("background")
	
func clear_choices():
	var nodes = choice_container.get_children()
	for node in nodes:
		node.queue_free()
		
	choice_pos = 0
	

func set_choice(var display_text, var id):
	var lbl = select_label.new()
	lbl.set_text(display_text)
	lbl.set_pos( Vector2(choice_x_pos, choice_y_pos + (choice_offset * choice_pos) ) )
	
	lbl.set_selected_callback(self, "on_choice_selected", id)
	
	choice_container.add_child(lbl)
	choice_pos += 1

func set_callback(var obj, var func_ptr):
	callback_obj = obj
	callback_func = func_ptr

func on_choice_selected(id):
	callback_obj.call(callback_func, id)
