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
	$GameTurn.visible = true
	
func ShowPlayerEnd():
	$GameEnd.visible = true
	var game = get_tree().get_nodes_in_group("Game")[0] as Game
	
	$GameEnd/Label.text = ""
	for result in game.Result:
		$GameEnd/Label.text += result
