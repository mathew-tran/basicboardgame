extends Node3D

var CurrentPlayer : Player

func _ready():
	
	$Dice.OnDiceRollCompleted.connect(OnDiceRollCompleted)
	EventManager.RollButtonClicked.connect(OnRollButtonClicked)
	$StartTileMarker.global_position = $Tiles.get_child(0).global_position
	$Camera3D.SetFocus($StartTileMarker, .2)
	SetupPlayers()
	
	
func SetupPlayers():
	
	for player in $Players.get_children():
		var newTile = $Tiles.GetNextTile(player.CurrentTile)
		player.MoveToTargetTile(newTile)
		await player.MoveCompleted
		
	GetNextPlayer()
	
func GetNextPlayer():
	CurrentPlayer = $Players.get_child(0)
	CurrentPlayer.Activate()
	FocusDicePosition()
	
func OnRollButtonClicked():
	FocusDicePosition()
	
func FocusDicePosition():
	$Camera3D.SetFocus($DiceFocusPosition, 4)
	
func FocusPlayerPosition():
	$Camera3D.SetFocus(CurrentPlayer, 1.5)
	
func OnDiceRollCompleted(amount):
	FocusPlayerPosition()
	await get_tree().create_timer(2).timeout
	var spacesToMove = amount
	while spacesToMove > 0:
		var newTile = $Tiles.GetNextTile(CurrentPlayer.CurrentTile)
		CurrentPlayer.MoveToTargetTile(newTile)
		await CurrentPlayer.MoveCompleted
		spacesToMove -= 1
