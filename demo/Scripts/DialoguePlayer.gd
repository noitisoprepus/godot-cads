extends Node

signal dialogue_started
signal dialogue_finished

onready var dialogue_ui = get_node("/root/Game/UI/DialogueUI")

var dialogue: Dictionary = {}
var current_event: Dictionary = {}
var current_state: String = ""


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
	_load_dialogue(json_file)

    # Retrieve current_state value using key
	# if (current_state == ""):
	# 	current_state = "Start"
	_process_state()


# TODO: Add an else statement for catching and displaying errors
func _load_dialogue(path):
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
    pass


# Think of a way to dynamically connect this to the player's interaction
# func on_interact_pressed():
#   start()
#   pass


# func on_next_pressed():
#   next()
#   pass