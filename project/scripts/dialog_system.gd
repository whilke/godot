extends Node

var chat_node
var options_node
var options_dict = {}

var dialog_stack = []

func _init(var chatNode, var optionsNode):

	chat_node = chatNode
	options_node = optionsNode
	
	options_node.set_callback(self, "on_option_selected")

func _ready():
	# Initialization here
	pass
	
func load_dialog(var res):

	var json = File.new()
	json.open(res, 1)
	var d = {}
	
	var err = d.parse_json(json.get_as_text())
	
	if (err!=OK):
		printerr("dialog_system:load_dialog - failed to parse json")
	
	return d;

func display_dialog(var res):
	
	var previous_dialog = null
	var dialog = null
	
	if (dialog_stack.size() > 0):
		previous_dialog = dialog_stack[ dialog_stack.size()-1]
	
	if (res == "back" && dialog_stack.size() > 1):
		previous_dialog = dialog_stack[ dialog_stack.size()-2]
		dialog_stack.remove( dialog_stack.size()-1 )
		dialog_stack.remove( dialog_stack.size()-2 )
		dialog = previous_dialog
	else:	
		if (previous_dialog == null || previous_dialog.target != res):
			dialog = load_dialog(res)
		else:
			var text = previous_dialog["starting_text"]
			chat_node.display_text(text)
			return
	
	var text = dialog["starting_text"]	
	chat_node.display_text(text)	
	
	var options_array = dialog["choices"]	

	options_node.clear_choices()
	options_dict = {}
	
	for option in options_array:
		build_option(option)

	dialog.target = res
	dialog_stack.push_back(dialog)
	
func build_option(var option):
	options_dict[option.target] = option
	options_node.set_choice(option.text, option.target)

func on_option_selected(var id):
	var option = options_dict[id]
	var target = option.target
	display_dialog(target)