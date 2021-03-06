extends KinematicBody2D

# Builds on actor base class. Functionality for Kinempatic actors 

# This is the base actor script that all 2d enteties that move or do actions will 
# inherit from. this includes players and enemies 

# Dircetion constants
const LEFT = Vector2(-1,0)
const RIGHT = Vector2(1,0)
const UP = Vector2(0,-1)
const DOWN = Vector2(0,1)
const FORWARD = UP

var damageTable
var explosion = preload("res://scenes/miniGames/galaga/Explosion0.tscn")
export var move_speed = 550 #250 # default move speed

export (int) var hp # default hit point total 
var max_hp = hp
var score_value = 0
# what this entity is targeting. ie, looking at, moving twards, attacking ect 
var target
# True to show healthbar. False to hide it. default false
var show_health_bar = false

func _ready():
	# find damage table
	damageTable = get_tree().get_root().get_node("/root/Galaga/DamageTable")
	if !damageTable:
		print("Failed to load damage table")
	pass

# default death function
func _die():
	# always emmit signal? may not always be connected to anything
	emit_signal("score_changed", score_value) 
	var explosion_instance = explosion.instance()
	explosion_instance.position = get_global_position()
	get_tree().get_root().add_child(explosion_instance)
	queue_free()
	pass 

# default on hit function
func _hit(group):
	# look up tag in dmg table
	var damage = damageTable._getDamage(group)
	#print(str("Took ", damage, " damage from ", group))
	hp -= damage
	
	_post_hit()
	
	if hp <= 0:
		_die()
	
	
func _post_hit():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
