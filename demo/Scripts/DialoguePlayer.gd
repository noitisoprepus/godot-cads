extends Node

signal dialogue_started
signal dialogue_finished

export(String) var d_key
export(String) var d_name
export(String, FILE, "*.json") var d_json

# TODO: Preload DialogueUI

var dialogue : Dictionary = {}
var current_state: String = ""  # TODO: Save this value somewhere to allow resuming


func start():
    emit_signal("dialogue_started")
    
    # Initial dialogue preparations
    load_dialogue(d_json)
    # TODO: Restore current_state value based on key
    if (current_state == ""):
        current_state = "Start"
    next()


func next():
    if current_state == "END":
        # TODO: Close Dialogue UI
        # TODO: Reset state
        current_state = "Repeat"
        emit_signal("dialogue_finished")
        return
    
    # Process current_state
    var current_event = process_state()
    process_event(current_event)


# TODO: Add an else statement for catching and displaying errors
func load_dialogue(file):
    var dialogue_file = File.new()
    if dialogue_file.file_exists(file):
        dialogue_file.open(file, dialogue_file.READ)
        var dialogue_dict = parse_json(dialogue_file.get_as_text())
        if typeof(dialogue_dict.result) == TYPE_DICTIONARY:
            dialogue = dialogue_dict


# Parse dialogue on the given state
func process_state():
    if dialogue.has(current_state):
        var event: Dictionary = dialogue[current_state]
        current_state = event["next"]
        return event
    
    # display_message("Error. State not found")


func process_event(event):
    if event.has("dialogue"):
        display_message(event["dialogue"])
    pass


func display_message(content: Array):
    print(content)
    pass


func display_choice(choices: Array):
    print(choices)
    pass


# Think of a way to dynamically connect this to the player's interaction
# func on_interact_pressed():
#   start()
#   pass