extends Button

class_name SpellButton

@export var spell : Spell

func _ready() -> void:
	text = spell.getName()

func update_spell(new_spell : Spell):
	spell = new_spell
	text = new_spell.getName()

func getSpellName() :
	return spell.getName()
