extends Node

signal dialogue_started
signal dialogue_finished

export(String) var intertable_key
export(String) var interactable_name
export(String, FILE, "*.json") var dialogue_json

onready var dialogue_player = get_node("/root/DialogueUI")

var dialogue : Dictionary = {}
var current_event: Dictionary = {}  # TODO: Save these values
var current_state: String = ""      # somewhere to allow resuming

func start():
    emit_signal("dialogue_started")
    
    # Initial dialogue preparations
    _load_dialogue()
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
    
    _process_state()


# TODO: Add an else statement for catching and displaying errors
func _load_dialogue():
    var dialogue_file = File.new()
    if dialogue_file.file_exists(dialogue_json):
        dialogue_file.open(dialogue_json, dialogue_file.READ)
        var dialogue_dict = parse_json(dialogue_file.get_as_text())
        if typeof(dialogue_dict.result) == TYPE_DICTIONARY:
            dialogue = dialogue_dict
        # else:
        #     display_message(["Error. Dialogue JSON is not a Dictionary."])
    # else:
        # display_message(["Error. Dialogue JSON does not exist"])


func _process_state():
    if dialogue.has(current_state):
        current_event = dialogue[current_state]
        current_state = current_event["next"]
        _process_event()
    # else:
    #   display_message(["Error. State" + current_state + " not found"])


# TODO: Queue the events
func _process_event():
    if current_event.has("dialogue"):
        dialogue_player.queue_message(current_event["dialogue"])
        pass
    if current_event.has("choice"):
        dialogue_player.queue_choice(current_event["choices"])
        pass
    if current_event.has("function"):
        dialogue_player.queue_function(current_event["function"])
        pass
    dialogue_player.start_queue()


# Think of a way to dynamically connect this to the player's interaction
# func on_interact_pressed():
#   start()
#   pass


# func on_next_pressed():
#   next()
#   pass