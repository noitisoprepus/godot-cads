extends Node

export(String, FILE, "*.json") var dialogue_json

var dialogue_keys = []
var dialogue_name: String = ""
var dialogue_content: String = ""
var current_dialogue_index: int = 0

signal dialogue_started
signal dialogue_finished

func start_dialogue():
    emit_signal("dialogue_started")
    parse_dialogue()
    current_dialogue_index = 0
    display_dialogue()


func next_dialogue():
    current_dialogue_index += 1
    if current_dialogue_index == dialogue_keys.size():
        emit_signal("dialogue_finished")
        return
    display_dialogue()


func display_dialogue():
    dialogue_content = dialogue_keys[current_dialogue_index].text
    dialogue_name = dialogue_keys[current_dialogue_index].name


func load_dialogue(path):
    var dialogue_file = File.new()
    if dialogue_file.file_exists(path):
        dialogue_file.open(path, dialogue_file.READ)
        return parse_json(dialogue_file.get_as_text())


func parse_dialogue():
    var dialogue = load_dialogue(dialogue_json)
    dialogue_keys.clear()
    for key in dialogue:
        dialogue_keys.append(dialogue[key])