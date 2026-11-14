extends RigidBody2D

@export var spin_sprites: Node2D
@export var forceValue: float = 50.0
@export var player: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	spin_sprites.rotation += deg_to_rad(45)
	
	var force = Vector2.ZERO
	var direction = Vector2.ZERO
	
	match player:
		1:
			direction = Input.get_vector("left1", "right1", "up1", "down1")
		2:
			direction = Input.get_vector("left2", "right2", "up2", "down2")
			
	force = direction.normalized() * forceValue
	apply_central_force(force)
