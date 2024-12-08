class_name CropsCursorComponent
extends Node

@export var tilled_soid_tilemap_layer: TileMapLayer

@onready var player:Player = get_tree().get_first_node_in_group("player")

var corn_plant_scene = preload("res://scenes/objects/plants/corn.tscn")
var tomatao_plant_scene = preload("res://scenes/objects/plants/tomato.tscn")

var mouse_position: Vector2
var cell_position: Vector2i
var cell_source_id: int
var local_cell_position: Vector2
var distance: float

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("remove_dirt"):
		if ToolManager.selected_tool == DataTypes.Tools.TillGround:
			get_cell_under_mouse()
			remove_crop()
	elif event.is_action_pressed("hit"):
		if ToolManager.selected_tool == DataTypes.Tools.PlantCorn or ToolManager.selected_tool == DataTypes.Tools.PlantTomato:
			get_cell_under_mouse()
			add_crop()

func get_cell_under_mouse() -> void:
	mouse_position = tilled_soid_tilemap_layer.get_local_mouse_position()
	cell_position = tilled_soid_tilemap_layer.local_to_map(mouse_position)
	cell_source_id = tilled_soid_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = tilled_soid_tilemap_layer.map_to_local(cell_position)
	distance = player.global_position.distance_to(local_cell_position)

func add_crop() -> void:
	if distance < 20.0:
		if ToolManager.selected_tool == DataTypes.Tools.PlantCorn:
			create_crop_scene(corn_plant_scene)
		
		if ToolManager.selected_tool == DataTypes.Tools.PlantTomato:
			create_crop_scene(tomatao_plant_scene)

func create_crop_scene(crop_scene: PackedScene) -> void:
	var scene_instance = crop_scene.instantiate() as Node2D
	scene_instance.global_position = local_cell_position
	get_parent().find_child("CropFields").add_child(scene_instance)

func remove_crop() -> void:
	if distance < 20.0:
		var crop_nodes = get_parent().find_child("CropFields").get_children()
		
		for node: Node2D in crop_nodes:
			if node.global_position == local_cell_position:
				node.queue_free()
