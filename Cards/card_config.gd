@tool
class_name CardConfig
extends Resource

enum CardType {
	Basic, ##Core cards that will decide the winner.
	Trick, ##Special cards to give you an advantage.
}

enum BasicCard {
	Rock = 1, ##Rock beats Scissors.
	Paper = -1, ##Paper beats Rock.
	Scissors = 0, ##Scissors beat Paper.
}

enum TrickCard {
	Golden_Shot, ##Shot the opponent and continue your turn.
	Cheat, ##Allows you to break one rule from the rulebook.
	Wildcard, ##Pick an unknown card from five random cards, sending the rest to the discard pile.
	Reshuffle, ##Draw new cards equal to the current hand count, sending the old cards to the discard pile.
	Peek, ##Reveals the opponent's current hand.
	Replenish, ##Restores one charge.
}

@export_group("Card Type")
@export var card_type: CardType = CardType.Basic: ##The type of the card.
	set(value):
		card_type = value
		notify_property_list_changed()
@export var basic_card_name: BasicCard = BasicCard.Rock:
	set(value):
		basic_card_name = value
		card_value = value
		notify_property_list_changed()
@export var trick_card_name: TrickCard:
	set(value):
		trick_card_name = value
		card_value = 2
		notify_property_list_changed()
@export_group("Card Display")
@export_subgroup("Card Graphics")
@export var card_graphic: Texture ##The image representing the card.
@export var pixel_size: float = 0.0025 ##The size of the card graphic, used by Sprite3Ds.
@export var image_offset: Vector2 ##The offset of the card image.
@export_subgroup("")
@export var card_name: String ##The name of the card displayed.
@export_multiline var card_description: String ##Describes what this card does.
@export var card_value: int = 2 ##The value of the card. This is used to calculate the game score and determine the winner. [u]Trick cards[/u] are defaulted to 2 to symbolise None.

func  _init() -> void:
	if card_type == CardType.Basic:
		card_name = str(BasicCard.find_key(basic_card_name)).replace("_", " ")
	elif card_type == CardType.Trick:
		card_name = str(TrickCard.find_key(trick_card_name)).replace("_", " ")

func _validate_property(property: Dictionary) -> void:
	if card_type == CardType.Basic:
		card_value = int(basic_card_name)
		if property.name == "basic_card_name":
			property.usage = PROPERTY_USAGE_EDITOR
		if property.name == "trick_card_name":
			property.usage = PROPERTY_USAGE_NONE
	elif card_type == CardType.Trick:
		card_value = 2
		if property.name == "basic_card_name":
			property.usage = PROPERTY_USAGE_NONE
		if property.name == "trick_card_name":
			property.usage = PROPERTY_USAGE_EDITOR
