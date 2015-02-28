
extends Node2D

const x_character_pos = 500
const y_character_pos = 140

const dialog_system = preload("res://scripts/dialog_system.gd")

var characterNode
var chatNode
var choiceNode
var dlg_node

export(int, 1) var characterSide = 0

func _ready():
	# Initialization here
	characterNode = get_node("character")
	chatNode = get_node("chatNode")
	choiceNode = get_node("choiceNode")	
	dlg_node = dialog_system.new(chatNode, choiceNode)
	
	choiceNode.set_chat_node(chatNode)
	
	if characterSide == 0:
		characterNode.set_pos(Vector2(-x_character_pos,y_character_pos))
	else:
		characterNode.set_pos(Vector2(x_character_pos,y_character_pos))		
		
	dlg_node.display_dialog("res://dialogs/dialog_test_1.json")
	

