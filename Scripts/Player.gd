extends RigidBody2D

class_name Player

signal DieSignal

@export var jump_force: float 
@export var wing_player: AudioStreamPlayer2D
@export var min_pitch: float
@export var max_pitch: float
@export var hit_player: AudioStreamPlayer2D
@export var die_player: AudioStreamPlayer2D
var disable_input: bool = false
var random_generator: RandomNumberGenerator

func _ready():
	random_generator = RandomNumberGenerator.new()
	pass

func _input(_event):
	if (not(disable_input) and Input.is_action_just_pressed ("Jump")):
		set_linear_velocity(Vector2(0, -1 * jump_force))
		play_sound()
	elif (disable_input and Input.is_action_just_pressed ("Jump")):
		get_tree().reload_current_scene()
	pass

func play_sound():
	random_generator.randomize()
	wing_player.pitch_scale = random_generator.randf_range(min_pitch, max_pitch)
	wing_player.play()
	pass

func _on_body_entered(body: Node2D):
	if (body.is_in_group("Tube") or body.is_in_group("Floor")):
		hit_player.play()
		die_player.play()
		disable_input = true
		emit_signal("DieSignal")
	pass
