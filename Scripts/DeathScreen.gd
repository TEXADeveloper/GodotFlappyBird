extends Control

@export var player: Player

func _ready():
	player.connect("DieSignal", on_die_signal, 0)
	pass

func on_die_signal():
	self.visible = true
	pass
