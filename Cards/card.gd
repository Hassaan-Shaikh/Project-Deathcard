class_name Card 
extends AnimatableBody3D

@export var card_config: CardConfig

@onready var card_mesh: MeshInstance3D = $Visuals/CardMesh
@onready var card_name_label: Label3D = $Visuals/CardNameLabel
@onready var card_image_sprite: Sprite3D = $Visuals/CardImageSprite
@onready var card_desc: Label3D = $Visuals/CardDesc

func _ready() -> void:
	if card_config.card_type == CardConfig.CardType.Trick:
		var mat := card_mesh.get_surface_override_material(0) as StandardMaterial3D
		mat.albedo_color = Color8(127, 84, 212)
	elif card_config.card_type == CardConfig.CardType.Basic:
		var mat := card_mesh.get_surface_override_material(0) as StandardMaterial3D
		mat.albedo_color = Color8(150, 22, 22)
	card_image_sprite.texture = card_config.card_graphic
	card_image_sprite.pixel_size = card_config.pixel_size
	card_image_sprite.offset = card_config.image_offset
	card_name_label.text = card_config.card_name
	card_desc.text = card_config.card_description
	print("------------------------------")
	print(card_config.card_value)
	print(card_config.card_name)
	print("------------------------------")
