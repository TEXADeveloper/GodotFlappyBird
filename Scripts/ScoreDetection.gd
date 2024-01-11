extends Area2D

@export var tube: Tube

@export var stream_player: AudioStreamPlayer2D
@export var min_pitch: float
@export var max_pitch: float
var random_generator: RandomNumberGenerator

func _ready():
	random_generator = RandomNumberGenerator.new()
	pass

func _on_body_entered(_body: Node2D):
	random_generator.randomize()
	stream_player.pitch_scale = random_generator.randf_range(min_pitch, max_pitch)
	stream_player.play()
	tube.scored()
	pass
