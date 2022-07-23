class_name Interaction
extends Resource

export var dialogue_states: Dictionary = {}

func save_dialogue_state(key: String, state: String) -> void:
    dialogue_states[key] = state


func reset_dialogue_state(key: String) -> void:
    dialogue_states[key] = ""


func get_dialogue_state(key: String) -> String:
    if  dialogue_states.has(key):
        return dialogue_states[key]
    else:
        return ""