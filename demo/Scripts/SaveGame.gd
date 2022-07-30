extends Node

const GAME_DATA_PATH: String = "user://game_data.dat"

var data: Dictionary = {}

func write_game_data() -> void:
    var file = File.new()
    file.open(GAME_DATA_PATH, File.WRITE)
    file.store_var(GAME_DATA_PATH)
    file.close()


func load_game_data() -> void:
    var file = File.new()
    if not file.file_exists(GAME_DATA_PATH):
        data = {
            "dialogues" : {}
        }
        write_game_data()

    file.open(GAME_DATA_PATH, File.READ)
    data = file.get_var()
    file.close()