extends CanvasLayer

const LIFE_ROW_SIZE = 8
const LIFE_OFFSET = 36

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(Globals.health)
	
	$life.texture = null
	
	for child in $life.get_children():
		child.queue_free()
	
	for i in Globals.health:
		var new_life = Sprite2D.new()
		new_life.texture = load("res://asset/Lifes_placeholder sheet.png")
		new_life.hframes = 2
		new_life.name = "Life_" + str(i + 1)
		$life.add_child(new_life)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var children = $life.get_children()
	
	for life in children:
		var index = life.get_index()
		var x = (index % LIFE_ROW_SIZE) * LIFE_OFFSET
		var y = (index / LIFE_ROW_SIZE) * LIFE_OFFSET
		life.position = Vector2(x,y)
		
		var last_life = floor(Globals.health)
		if index + 1 > last_life:
			life.frame = 0
		else:
			life.frame = 1
