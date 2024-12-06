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
		
	CurrentValue = 0
	bIsRolling = true
	var index = 0
	
	for die in get_children():
		await get_tree().process_frame
		die.global_position = InitialPositions[index]
		await get_tree().process_frame
		index += 1
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
