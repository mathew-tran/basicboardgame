extends VBoxContainer


func _ready():
	EventManager.RoundsLeft.connect(OnRoundsLeft)
	
func OnRoundsLeft(rounds):
	if rounds == 1:
		$Amount.text = "LAST"
	else:
		$Amount.text = str(rounds)	
