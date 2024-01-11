extends Node

class_name TubeManager

@export var score: Score

@export var start_position: Vector2
@export var max_y: float
@export var min_y: float
@export var time_between_spawns: float
@export var multiplier: float
@export_range(0, 1) var speed_boost: float
@export_range(0, 1) var spawn_boost: float
@export var max_speed_multiplier: float
var timer: float
var random_generator: RandomNumberGenerator
var enabled_nodes: Array[Node2D] = []
var disabled_nodes: Array[Node2D] = []

var spawn: bool = true

func _ready():
	random_generator = RandomNumberGenerator.new()
	for child in self.get_children():
		if (child is Node2D):
			disabled_nodes.append(child)
	
	var player = get_node("../Flappy")
	player.connect("DieSignal", on_die_signal, 0)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (spawn):
		timer = timer + delta
		if (timer >= time_between_spawns):
			timer = 0
			var to_spawn: Node2D = disabled_nodes[0]
			to_spawn.visible = true
			_change_array(disabled_nodes, enabled_nodes, to_spawn)
			_set_position(to_spawn)
	pass

func _change_array(from: Array[Node2D], to: Array[Node2D], obj: Node2D):
	from.erase(obj)
	to.append(obj)
	pass

func _set_position(node: Node2D):
	node.position = start_position
	
	random_generator.randomize()
	var random_value: float = random_generator.randf_range(min_y, max_y)
	
	node.position.y = random_value
	pass

func _set_default_position(node: Node2D):
	_change_array(enabled_nodes, disabled_nodes, node)
	node.position = Vector2(-100, 285)
	node.visible = false
	pass

func on_die_signal():
	spawn = false
	pass

func scored():
	score.add_score()
	if (multiplier <= max_speed_multiplier):
		multiplier += speed_boost
	if (time_between_spawns * multiplier > spawn_boost + 1):
		time_between_spawns -= spawn_boost
