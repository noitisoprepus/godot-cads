class_name SaveGame
extends Resource

const GAME_DATA_PATH: String = "user://save.tres"

# export var version: float = 1.0

export var interaction: Resource

func write_game_data() -> void:
    ResourceSaver.save(GAME_DATA_PATH, self)


static func game_data_exists() -> bool:
    return ResourceLoader.exists(GAME_DATA_PATH)


static func load_game_data() -> Resource:
    if not ResourceLoader.has_cached(GAME_DATA_PATH):
        return ResourceLoader.load(GAME_DATA_PATH, "", true)
    
    # BUG workaround
    var file = File.new()
    if file.open(GAME_DATA_PATH, File.READ) != OK:
        printerr("Error. Could not read " + GAME_DATA_PATH + ".")
        return null
    
    var data: String = file.get_as_text()
    file.close()

    # TODO figure out make_random_path function
    var temp_file_path = make_random_path()
    while ResourceLoader.has_cached(temp_file_path):
        temp_file_path = make_random_path()
    
    if file.open(temp_file_path, File.WRITE) != OK:
        printerr("Error. Could not write " + temp_file_path + ".")
        return null
    
    file.store_string(data)
    file.close()

    var save = ResourceLoader.load(temp_file_path, "", true)
    save.take_over_path(GAME_DATA_PATH)

    var directory: Directory = Directory.new()
    directory.remove(temp_file_path)
    return save 