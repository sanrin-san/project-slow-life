class_name TestSceneSaveDataManagerComponent
extends Node

func _ready() -> void:
	# テスト用にセーブデータを読み込む
	call_deferred("load_test_scene")

func load_test_scene():
	SaveGameManager.load_game()
