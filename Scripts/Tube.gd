extends Node2D

class_name Tube

@export var tube_manager: TubeManager

@export var speed: float
@export var min_x: float
var move: bool = true

func _ready():
	var player = get_node("../../Flappy")
	player.connect("DieSignal", on_die_signal, 0)
	pass

func _process(delta):
	if (move):
		self.position.x = self.position.x + speed * tube_manager.multiplier * delta
		if (self.position.x <= min_x):
			tube_manager._set_default_position(self)
	pass

func on_die_signal():
	move = false
	pass

func scored():
	tube_manager.scored()
	pass
