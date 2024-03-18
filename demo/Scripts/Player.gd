extends CharacterBody2D

var canMove: bool = true 

@onready var dialogue_player = get_node("/root/Game/DialoguePlayer")

func _ready():
    dialogue_player.connect("dialogue_started", Callable(self, "_on_dialogue_started"))


func _on_dialogue_started():
    canMove = false