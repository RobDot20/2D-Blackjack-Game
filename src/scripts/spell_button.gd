extends Button

class_name SpellButton

@export var spell : Spell

func update_spell(new_spell : Spell):
	spell = new_spell
	text = new_spell.spell_name

func getSpellName() :
	return spell.getName()
