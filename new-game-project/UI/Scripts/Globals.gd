extends Node2D

var health = 4

func _process(_delta: float) -> void:
	if health < 1:
		health = 4
