extends Node

@export var speed: float
@export var tube_manager: TubeManager
var start_position: float
var move: bool = true

func _ready():
	start_position = self.position.x
	
	var player = get_node("../Flappy")
	player.connect("DieSignal", on_die_signal, 0)
	pass

func _process(delta):
	if (move):
		var position = self.position
		self.position.x = position.x + speed * tube_manager.multiplier * delta
		if (self.position.x <= -start_position):
			self.position.x = -self.position.x
	pass

func on_die_signal():
	move = false
	pass
