extends Node

export(NodePath) var main_menu

func _ready():
	main_menu = get_node(main_menu)
