extends CanvasLayer


func _ready():
	HideAllUI()
	EventManager.ChangeGameState.connect(OnChangeGameState)

func OnChangeGameState(state : EventManager.UI_STATE):
	HideAllUI()
	if state == EventManager.UI_STATE.PLAYER_START:
		ShowPlayerStart()
	if state == EventManager.UI_STATE.GAME_END:
		ShowPlayerEnd()

func HideAllUI():
	$GameTurn.visible = false
	$GameEnd.visible = false
		
func ShowPlayerStart():
	
	if EventManager.GameReference.CurrentPlayer.IsHuman():
		$GameTurn.visible = true
	else:
		# Need to move this to an AI controller under the player
		await get_tree().create_timer(1.0).timeout
		$GameTurn/Roll.Press()
	
func ShowPlayerEnd():
	$GameEnd.visible = true
	
	$GameEnd/Label.text = ""
	for result in EventManager.GameReference.Result:
		$GameEnd/Label.text += result
