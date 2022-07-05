extends Node

# TODO: Add an else statement for catching and displaying errors
func load_dialogue(file):
    var dialogue_file = File.new()
    if dialogue_file.file_exists(file):
        dialogue_file.open(file, dialogue_file.READ)
        var dialogue_dict = parse_json(dialogue_file.get_as_text())
        if typeof(dialogue_dict.result) == TYPE_DICTIONARY:
            return dialogue_dict

func process_state():
    pass

func next_state():
    pass

# func parse_dialogue(file):
#     var dialogue = load_dialogue(file)
    # dialogue_keys.clear()
    # for key in dialogue:
    #     dialogue_keys.append(dialogue[key])