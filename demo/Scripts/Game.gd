extends Node

@export var main_menu: NodePath

func _ready():
	main_menu = get_node(main_menu)
