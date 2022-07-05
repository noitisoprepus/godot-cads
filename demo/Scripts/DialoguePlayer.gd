extends Node

signal dialogue_started
signal dialogue_finished

export(String, FILE, "*.json") var dialogue_json

const DialogueParser = preload("res://Scripts//DialogueParser.gd")
var parser = DialogueParser.new()

var dialogue_keys = []
var dialogue_name: String = ""
var dialogue_content: String = ""
var current_state: String = ""  # Save this value somewhere to allow resuming

func start_dialogue():
    emit_signal("dialogue_started")
    
    # Initial dialogue preparations
    var dialogue = parser.load_dialogue(dialogue_json)
    dialogue_keys.clear()
    for key in dialogue:
        dialogue_keys.append(dialogue[key])
    
    display_dialogue()


func next_dialogue():
    if current_state == "END":
        # Close Dialogue UI
        # Reset state
        current_state = "Repeat"
        emit_signal("dialogue_finished")
        return
    display_dialogue()


func display_dialogue():
    # dialogue_content = dialogue_keys[current_dialogue_index].text
    # dialogue_name = dialogue_keys[current_dialogue_index].name
    pass

# Think of a way to dynamically connect this to the player's interaction
# func on_interact_pressed():
#   start_dialogue()
#   pass