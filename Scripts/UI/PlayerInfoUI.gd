extends Panel

var PlayerReference : Player

func _ready():
	OnPlayerDeactivated()

func Setup(player : Player):
	PlayerReference = player
	PlayerReference.PlayerUpdate.connect(OnPlayerUpdate)
	PlayerReference.PlayerActivated.connect(OnPlayerActivated)
	PlayerReference.PlayerDeactivated.connect(OnPlayerDeactivated)
	
	$PlayerImage.texture = player.PlayerImage
	$PlayerName.text = player.GetName()
	OnPlayerUpdate()

func OnPlayerUpdate():
	$Data/HBoxContainer2/FlagAmount.text = "x " + str(PlayerReference.GetVictoryPoints())
	$Data/HBoxContainer/CoinAmount.text = "x " + str(PlayerReference.GetCoins())

func OnPlayerActivated():
	$Active.visible = true
	
func OnPlayerDeactivated():
	$Active.visible = false
