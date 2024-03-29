extends Node2D

var coins = 0
var coinsinlevel = 0

var Portal
var levelnum = 1
var maxlevel = 2

func _ready():
	GetCoinCount()



# UI
func ResetCoins():
	coins = 0

func GetCoinCount():
	coinsinlevel = get_tree().get_nodes_in_group("Coin").size()

func AddCoin():
	coins += 1
	if coins == coinsinlevel:
		Portal.TurnOn()



# PLAYER
func PlayerDeath():
	ResetCoins()
	ReloadLevel()

func PlayerWin():
	levelnum += 1
	if levelnum > maxlevel:
		levelnum = 1
	
	ResetCoins()
	LoadLevel()



# LEVEL MANAGER
func ReloadLevel():
	get_tree().reload_current_scene()

func LoadLevel():
	pass
	#add_child( load("res://Scenes/Level"+ str(levelnum) +".tscn").instantiate() )
