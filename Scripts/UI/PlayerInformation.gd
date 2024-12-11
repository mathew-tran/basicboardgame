extends VBoxContainer

var PlayerInfoClass = preload("res://Prefabs/UI/PlayerInfoUI.tscn")
func _ready():
	for child in get_children():
		child.queue_free()
		
	EventManager.GameStart.connect(OnGameStart)

func OnGameStart():
	for player in EventManager.GameReference.GetPlayers():
		var instance = PlayerInfoClass.instantiate()
		instance.Setup(player)
		add_child(instance)
