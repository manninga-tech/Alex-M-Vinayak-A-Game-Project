extends CanvasLayer

const LIFE_ROW_SIZE = 8
const LIFE_OFFSET = 32

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(Globals.health)
	for i in Globals.health:
		var new_life = Sprite2D.new()
		new_life.texture = $life.texture
		new_life.hframes = $life.hframes
		$life.add_child(new_life)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
