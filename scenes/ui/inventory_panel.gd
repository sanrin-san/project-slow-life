extends PanelContainer

@onready var labels: Dictionary = {
	"log": $MarginContainer/VBoxContainer/Log/LogLabel,
	"stone": $MarginContainer/VBoxContainer/Stone/StoneLabel,
	"corn": $MarginContainer/VBoxContainer/Corn/CornLabel,
	"tomato": $MarginContainer/VBoxContainer/Tomato/TomatoLabel,
	"egg": $MarginContainer/VBoxContainer/Egg/EggLabel,
	"milk": $MarginContainer/VBoxContainer/Milk/MilkLabel
}

func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)

func on_inventory_changed(changed_items: Dictionary = InventoryManager.inventory) -> void:
	for item in labels.keys():
		labels[item].text = str(changed_items.get(item, 0))
