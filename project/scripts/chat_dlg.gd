
extends Node2D

var renderText
var renderPos
var renderTimer
var chatNode

func _ready():
	# Initialization here
	renderTimer = get_node("chat_bubble/chat_text/render_timer")
	chatNode = get_node("chat_bubble/chat_text")
	
func display_text(var text):
	renderText = text
	renderPos = 0
	chatNode.set_text("");
	renderTimer.start();


func _on_render_timer_timeout():
	if renderPos >= renderText.length():
		renderTimer.stop()
		return

	renderPos +=1
	var txt = renderText.substr(0, renderPos)
	
	chatNode.set_text(txt)
