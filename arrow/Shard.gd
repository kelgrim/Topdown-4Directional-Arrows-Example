extends Area2D

var speed = 3
var life_time = 0.25
onready var timer = $Timer

func _ready():
	timer.start(life_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.RIGHT.rotated(rotation).normalized() * speed

func _on_Timer_timeout():
	queue_free()
