extends Node

signal RollButtonClicked

signal RollCompleted(amount)
signal RoundsLeft(rounds)

signal GameOver

enum UI_STATE {
	GAME_START,
	PLAYER_START,
	RESOLVING,
	GAME_END
}

signal ChangeGameState(state)

var GameReference : Game
