extends Node

signal dialogue_started
signal dialogue_finished

onready var dialogue_ui = get_node("/root/Game/UI/DialogueUI")

var game_data: Dictionary= {}
var dialogue: Dictionary = {}
var current_event: Dictionary = {}
var current_state: String = ""
var current_key: String = ""


# func next():
	# if current_state == "END":
		# TODO: Close Dialogue UI
		# TODO: Reset state
	# 	current_state = "Repeat"
	# 	return

	# print("Processing dialogue")
	# _process_state()


func play(key, json_file):
	emit_signal("dialogue_started")
	current_key = key
	_load_dialogue(json_file)

	# Retrieve current_state value using key
	current_state = _get_dialogue_state(current_key)
	_process_state()


# TODO: Add an else statement for catching and displaying errors
func _load_dialogue(path: String):
	var dialogue_file = File.new()
	if dialogue_file.file_exists(path):
		dialogue_file.open(path, dialogue_file.READ)
		dialogue = parse_json(dialogue_file.get_as_text())
	# else:
		# display_message(["Error. Dialogue JSON does not exist"])


func _process_state():
	if dialogue.has(current_state):
		current_event = dialogue[current_state]
		current_state = current_event["next"]
		_process_event()
	# else:
	#   display_message(["Error. State" + current_state + " not found"])


func _process_event():
	if current_event.dialogue.empty():
		emit_signal("dialogue_finished")
		dialogue_ui.reset_ui()

		game_data.dialogues[current_key] = current_state
		SaveGame.write_game_data()
		return

	var content = current_event.dialogue.pop_front()
	dialogue_ui.update_content_label(content)


func _get_dialogue_state(key: String) -> String:
	SaveGame.load_game_data()
	game_data = SaveGame.data
	var state: String = "Start"
	if game_data.dialogues.has(key):
		state = game_data.dialogues[key]
	return state


func on_interact_pressed():
	_process_event()
