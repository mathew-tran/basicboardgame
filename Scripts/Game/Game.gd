extends Node3D

var CurrentPlayer : Player

func _ready():
	CurrentPlayer = $Players.get_child(0)
	$Dice.OnDiceRollCompleted.connect(OnDiceRollCompleted)
	
func OnDiceRollCompleted(amount):
	var spacesToMove = amount
	while spacesToMove > 0:
		var newTile = $Tiles.GetNextTile(CurrentPlayer.CurrentTile)
		CurrentPlayer.MoveToTargetTile(newTile)
		spacesToMove -= 1
