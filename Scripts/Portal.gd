extends Node2D

@onready var EffectFlashbang = preload("res://Scenes/Effects/EffectFlashbang.tscn")

@onready var statemachine = $AnimationTree["parameters/playback"]
@onready var enterarea = $EnterArea

var canactivate = false

func _ready():
	Manager.Portal = self
	$AnimationTree.active = true

func TurnOn():
	canactivate = true

func _on_enter_area_body_entered(body):
	if canactivate == true:
		add_child(EffectFlashbang.instantiate())
		enterarea.queue_free()

func Activate():
	statemachine.travel("On")

func _on_tp_area_body_entered(body):
	if statemachine.get_current_node() == "OnLoop":
		Manager.PlayerWin()
