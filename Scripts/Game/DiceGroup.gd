extends Node3D


var InitialPositions = []
var DiceRolled = []

signal OnDiceRollCompleted(amount)

var bIsRolling = false

var CurrentValue = 0
func _ready():
	for die in get_children():
		InitialPositions.append(die.global_position)
		die.Resolved.connect(OnDiceResolved)
		
	EventManager.RollButtonClicked.connect(Roll)
	
func Roll():
	if bIsRolling:
		return
	print("[GAME] Rolling..")
	CurrentValue = 0
	bIsRolling = true
	var index = 0
	
	await get_tree().create_timer(.5).timeout
	
	for die in get_children():
		die.MoveToPosition(InitialPositions[index])
		await die.MovedToPosition
		index += 1
		
	await get_tree().create_timer(1.5).timeout
	
	index = 0
	for die in get_children():
		die.ThrowDice()
	
	DiceRolled = []
	
	for die in get_children():
		DiceRolled.append(false)	
		
	
	await OnDiceRollCompleted

	bIsRolling = false
	
func OnDiceResolved(amount):
	CurrentValue += amount
	DiceRolled.pop_front()
	if DiceRolled.size() <= 0:
		OnDiceRollCompleted.emit(CurrentValue)
		print("[GAME] Total Value: " + str(CurrentValue))
