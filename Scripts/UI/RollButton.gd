extends Button


func _on_button_up():
	Press()

func Press():
	EventManager.RollButtonClicked.emit()
