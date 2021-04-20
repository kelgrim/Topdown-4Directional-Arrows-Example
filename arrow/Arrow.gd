extends Area2D

var speed = 3
var life_time = 0.50
var is_powershot = false

onready var timer = $Timer

var packed_shard = load("res://arrow/Shard.tscn")

func _ready():
	timer.start(life_time)

func _process(delta):
	position += Vector2.RIGHT.rotated(rotation).normalized() * speed

func spawn_shard(rot):
	var shard = packed_shard.instance()
	shard.rotation = rot
	shard.position = global_position
	get_parent().add_child(shard)
	

func _on_Timer_timeout():
	spawn_shard(rotation + deg2rad(45))
	spawn_shard(rotation + deg2rad(135))
	spawn_shard(rotation + deg2rad(225))
	spawn_shard(rotation + deg2rad(315))
	
	if (is_powershot):
		spawn_shard(rotation + deg2rad(0))
		spawn_shard(rotation + deg2rad(90))
		spawn_shard(rotation + deg2rad(180))
		spawn_shard(rotation + deg2rad(270))
		
	queue_free()
