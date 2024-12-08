class_name SaveLevelDataComponent
extends Node

var level_scene_name: String
var save_game_data_path: String = "user://game_data/"
var save_file_name: String = "save_%s_game_data.tres"
var game_data_resource: SaveGameDataResource

func _ready() -> void:
	add_to_group("save_level_data_component") # 他のノードからこのノードをグループを通じて簡単にアクセスできるようにする
	level_scene_name = get_parent().name

# ゲームデータを収集してgame_data_resourceに保存する
func save_node_data() -> void:
	var nodes = get_tree().get_nodes_in_group("save_data_component")
	
	game_data_resource = SaveGameDataResource.new()
	
	if nodes != null:
		for node in nodes:
			# SaveDataComponentに属している場合
			if node is SaveDataComponent:
				var save_data_resource: NodeDataResource = node._save_data()
				var save_final_resource = save_data_resource.duplicate()
				game_data_resource.save_data_nodes.append(save_final_resource)

func save_game() -> void:
	# 保存先のディレクトリが存在しない場合、作成
	if !DirAccess.dir_exists_absolute(save_game_data_path):
		DirAccess.make_dir_absolute(save_game_data_path)
	
	var level_save_file_name: String = save_file_name % level_scene_name # レベルごとの保存ファイル名を作成
	
	save_node_data()
	
	var result: int = ResourceSaver.save(game_data_resource, save_game_data_path + level_save_file_name)
	print("save result: ", result)

func load_game() -> void:
	var level_save_file_name: String = save_file_name % level_scene_name
	var save_game_path: String = save_game_data_path + level_save_file_name
	
	if !FileAccess.file_exists(save_game_path): # 保存ファイルが存在しない場合
		return
	
	game_data_resource = ResourceLoader.load(save_game_path)
	
	if game_data_resource == null: # リソースが正しく読み込めなかった場合
		return
	
	var root_node: Window = get_tree().root
	
	for resource in game_data_resource.save_data_nodes:
		if resource is Resource:
			if resource is NodeDataResource:
				resource._load_data(root_node) # ロードしたデータをルートノードに適用
