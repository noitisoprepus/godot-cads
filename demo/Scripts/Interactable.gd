extends Node

export(String) var interactable_key
export(String) var interactable_name
export(String, FILE, "*.json") var dialogue_json

onready var dialogue_player = get_node("/root/Game/DialoguePlayer")

var is_interacting: bool = false

func _on_Button_pressed():
	if not is_interacting:
		is_interacting = true
		dialogue_player.play(interactable_key, dialogue_json)
		dialogue_player.connect("dialogue_finished", self, "on_DialoguePlayerFinished")


func _on_DialoguePlayer_finished():
	is_interacting = false
	dialogue_player.disconnect("dialogue_finished", self, "on_DialoguePlayerFinished")