extends Node

signal interact

@export var interactable_key: String
@export var interactable_name: String
@export var dialogue_json # (String, FILE, "*.json")

@onready var dialogue_player = get_node("/root/Game/DialoguePlayer")

var is_interacting: bool = false

# Just a placeholder function
func _on_Button_pressed():
	if not is_interacting:
		is_interacting = true
		dialogue_player.play(interactable_key, dialogue_json)
		dialogue_player.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))
		self.connect("interact", Callable(dialogue_player, "on_interact_pressed"))
	else: 
		emit_signal("interact")


func _on_dialogue_finished():
	is_interacting = false
	dialogue_player.disconnect("dialogue_finished", Callable(self, "_on_dialogue_finished"))
	self.disconnect("interact", Callable(dialogue_player, "on_interact_pressed"))
