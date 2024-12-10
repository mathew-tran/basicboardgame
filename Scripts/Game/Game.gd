extends Node3D

var CurrentPlayer : Player
var Results = []
var RoundsLeft = 2

enum PLACEMENT {
	NULL,
	FIRST,
	SECOND,
	THIRD,
	FOURTH
}

func _ready():	
	$Dice.OnDiceRollCompleted.connect(OnDiceRollCompleted)
	EventManager.RollButtonClicked.connect(OnRollButtonClicked)
	$StartTileMarker.global_position = $Tiles.get_child(0).global_position
	$Camera3D.SetFocus($StartTileMarker, .2)
	SetupPlayers()
	EventManager.RoundsLeft.emit(RoundsLeft)
	EventManager.GameOver.connect(OnGameOver)
	
func SetupPlayers():
	
	for player in $Players.get_children():
		var newTile = $Tiles.GetNextTile(player.CurrentTile)
		player.MoveToTargetTile(newTile)
		await player.MoveCompleted
		
	GetNextPlayer()
	
func GetNextPlayer(bFocusNextPlayer = false):
	var index = $Players.get_children().find(CurrentPlayer)
	
	index += 1
	if index >= $Players.get_child_count():
		index = 0
		RoundsLeft -= 1
		if RoundsLeft <= 0:
			EventManager.GameOver.emit()
			return
		else:
			EventManager.RoundsLeft.emit(RoundsLeft)
	CurrentPlayer = $Players.get_child(index)
	$Pointer.SetPosition(CurrentPlayer.global_position)
	CurrentPlayer.Activate()
	
func OnRollButtonClicked():
	$Pointer.Hide()
	FocusDicePosition()
	
func FocusDicePosition():
	$Camera3D.SetFocus($DiceFocusPosition, 1.5)
	
func FocusPlayerPosition():
	$Camera3D.SetFocus(CurrentPlayer, 1.5)
	
func OnDiceRollCompleted(amount):
	FocusPlayerPosition()
	$Pointer.SetPosition(CurrentPlayer.global_position)
	await get_tree().create_timer(2).timeout
	$Pointer.Hide()
	var spacesToMove = amount
	while spacesToMove > 0:
		var newTile = $Tiles.GetNextTile(CurrentPlayer.CurrentTile)
		CurrentPlayer.MoveToTargetTile(newTile)
		await CurrentPlayer.MoveCompleted
		if  $Tiles.IsFirstTile(CurrentPlayer.CurrentTile):
			CurrentPlayer.AddVictoryPoint(1)
			
		spacesToMove -= 1
	GetNextPlayer()
	FocusPlayerPosition()

func OnGameOver():
	DetermineWinner()
	
func PlayerSort(a : Player , b : Player):
	return a.GetVictoryPoints() > b.GetVictoryPoints()

func DetermineWinner():
	var players = []
	for player in $Players.get_children():
		players.append(player)
		
	players.sort_custom(PlayerSort)
	
	print("Player Order")
	
	var currentPlacement = PLACEMENT.FIRST
	var placementPoints = -1
	for player in players:
		if player.GetVictoryPoints() < placementPoints:
			currentPlacement += 1
		if player.GetVictoryPoints() >= placementPoints:
			placementPoints = player.GetVictoryPoints()
			
			
		print("===")			
		print(PLACEMENT.keys()[currentPlacement])
		print(player.ToString())
