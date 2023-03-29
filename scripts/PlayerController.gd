extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
var health = 3
var ingredients = {"Foraged": 0, "Enemy": 0}
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var knockback = 0


func DecreaseHealth(knockbackDirection):
	health -= 1
	knockback = knockbackDirection
	$Polygon2D.modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.1).timeout
	$Polygon2D.modulate = Color(1, 1, 1)
	knockback = 0
	if health == 0:
		queue_free()

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0:
			velocity.y *= 1.1

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("Attack"):
		$HurtboxContainer/Area2D/Polygon2D.modulate = Color(1,0,0)
		for i in $HurtboxContainer/Area2D.get_overlapping_bodies():
			i.DecreaseHealth(-abs(position.x - i.position.x)/(position.x - i.position.x));
		await get_tree().create_timer(0.1).timeout
		$HurtboxContainer/Area2D/Polygon2D.modulate = Color(1,1,1)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		$HurtboxContainer.scale.x = sign(direction)
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if knockback != 0:
		velocity.x += 600 * knockback
	move_and_slide()
