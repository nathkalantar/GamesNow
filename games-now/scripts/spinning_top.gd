extends RigidBody2D

@export var spin_sprites: Node2D
@export var forceValue: float = 100.0
@export var player: int = 0
@export var rpm: int = 10000
@export var attack: int = 100
@export var defense: int = 100
@export var rpmLossRate: float = 100
@export var dashForceValue: float = 500.0
@export var timer: Timer
@export var dashChargeRate: int = 25
@export var glow: Sprite2D

var maxRpm: float
var timerRpm: float = 0.0
var directionToRemove: Vector2 = Vector2.ZERO
var dashMeter: int = 0
var timerDash: float = 0.0
var baseAttackValue: int = 0
var dashing: bool = false

func _ready() -> void:
	maxRpm = rpm
	baseAttackValue = attack
	_update_rpm_ui()
	_update_dash_ui()

func _process(_delta: float) -> void:
	timerDash += _delta
	if (timerDash > 1.0/dashChargeRate && dashMeter < 100):
		dashMeter += 1
		if (dashMeter > 100): dashMeter = 100
		_update_dash_ui()
		timerDash = 0
	
	timerRpm += _delta
	if (timerRpm > 1.0/rpmLossRate && rpm > 0):
		rpm -= 1
		if (rpm < 0): rpm = 0
		_update_rpm_ui()
		timerRpm = 0
	
	spin_sprites.rotation += deg_to_rad(45 * rpm/maxRpm)
	
	var force = Vector2.ZERO
	var dashForce = Vector2.ZERO
	var direction = Vector2.ZERO
	
	if (rpm > 0):
		match player:
			1:
				direction = Input.get_vector("left1", "right1", "up1", "down1")
				if Input.is_action_just_pressed("dash1") && dashMeter > 25:
					_dashAttack(dashMeter)
					dashing = true
					glow.show()
					dashMeter = 0
					_update_dash_ui()
					dashForce = direction.normalized() * dashForceValue
					directionToRemove = direction.normalized()
					freeze = true
					freeze = false
					apply_central_impulse(dashForce)
					timer.start()
			2:
				direction = Input.get_vector("left2", "right2", "up2", "down2")
				if Input.is_action_just_pressed("dash2") && dashMeter > 25:
					_dashAttack(dashMeter)
					dashing = true
					glow.show()
					dashMeter = 0
					_update_dash_ui()
					dashForce = direction.normalized() * dashForceValue
					directionToRemove = direction.normalized()
					freeze = true
					freeze = false
					apply_central_impulse(dashForce)
					timer.start()
	
		force = direction.normalized() * forceValue
		apply_central_force(force)

func _clash(atkDmg: int) -> void:
	if !dashing:
		var actualDmg: int
		actualDmg = atkDmg - defense
		if (actualDmg < 0): actualDmg = 0
		rpm -= actualDmg
		if (rpm < 0): rpm = 0
		_update_rpm_ui()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("spinspin") and body.has_method("_clash"):
		body.call("_clash", attack)
	
	if body.is_in_group("arena"):
		_clash(150)

func _update_rpm_ui():
	var uiNode = get_node("/root/BattleScene/GameUI")
	if (player == 1): uiNode._changeRpm1(rpm)
	elif (player == 2): uiNode._changeRpm2(rpm)

func _update_dash_ui():
	var uiNode = get_node("/root/BattleScene/GameUI")
	if (player == 1): uiNode._changeDash1(dashMeter)
	elif (player == 2): uiNode._changeDash2(dashMeter)

func _on_timer_timeout() -> void:
	var removeDashForce = -0.7*directionToRemove * dashForceValue
	apply_central_impulse(removeDashForce)
	attack = baseAttackValue
	dashing = false
	glow.hide()
	
func _dashAttack(dashPower: int) -> void:
	if (dashPower < 50): attack = baseAttackValue
	elif (dashPower >= 50 && dashPower < 75): attack = 3*baseAttackValue
	elif (dashPower >= 75 && dashPower < 100): attack = 5*baseAttackValue
	elif (dashPower >= 100): attack = 10*baseAttackValue
