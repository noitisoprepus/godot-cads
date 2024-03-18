extends Control

@onready var content_panel = $Panel
@onready var content_label = $Panel/RichTextLabel

func _ready():
    reset_ui()


func reset_ui():
    content_panel.hide() # BUG hiding does not work
    update_content_label("")


func update_content_label(content: String) -> void:
    content_panel.show()
    content_label.text = content