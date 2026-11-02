class_name HurtBox
extends Area2D


func _ready() -> void:
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		print(body)
		if body.name == "Void":
			owner.fling_y = 2.7
		else:
			owner.fling_y = 1.2
		owner.damage = true
