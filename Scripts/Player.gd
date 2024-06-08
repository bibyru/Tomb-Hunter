extends CharacterBody2D

@onready var EffectDeath = preload("res://Scenes/Effects/EffectDeath.tscn")

@onready var AnimTree = $AnimationTree
@onready var DeathTimer = $DeathTimer
@onready var Sprite = $Sprite2D

const grav = 1.5
const hatthreshold = 500

var dead = false
var dir = 0
var speed = 12
var jumpforce = 30
var deltamult = 1000

var statemachine



func _ready():
	AnimTree.active = true
	statemachine = AnimTree["parameters/playback"]



func _input(event):
	if event.is_action_pressed("Test"):
		pass



func Die():
	if dead == false:
		dead = true
		statemachine.travel("Die")
		
		add_child(EffectDeath.instantiate())
		
		if DeathTimer.is_stopped():
			DeathTimer.start()

func _on_death_timer_timeout():
	Manager.PlayerDeath()



func _physics_process(delta):
	
	if dead == false:
		
		if is_on_floor():
			if dir == 0:
				statemachine.travel("Idle")
			else:
				statemachine.travel("Run")
		else:
			if velocity.y < 0:
				statemachine.travel("Jump")
			else:
				if velocity.y < hatthreshold:
					statemachine.travel("Fall")
				else:
					statemachine.travel("Fall_Far")
		
		
		if Input.is_action_pressed("Right"):
			dir = 1
			Sprite.flip_h = false
		elif Input.is_action_pressed("Left"):
			dir = -1
			Sprite.flip_h = true
		else:
			dir = 0
		
		if Input.is_action_just_pressed("Jump") && is_on_floor():
			velocity.y -= jumpforce * delta * deltamult
		
		
		velocity.x = dir * speed * delta * deltamult
		
		if !is_on_floor():
			if velocity.y < hatthreshold:
				velocity.y += grav * delta * deltamult
			else:
				velocity.y = hatthreshold
		
		move_and_slide()
