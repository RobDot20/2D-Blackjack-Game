
#vreau sa iau fiecare cifra si litera si sa le dau preload aici in scriptul asta ca sa schimb in functie de ce
#carte primeste in export
#la fel si la fiecare imagine ca mi se pare mai usor decat sa stau sa misc regiunea de la nod ul asta pt fiecare
#carte in parte, dar se poate scripta si asta daca nu reusim ig
#ar fi o idee sa transformam toate zonele albe dintre carti in spatiu gol sa ramanem doar cu desenele si dupa le
#dam load
extends NinePatchRect

@onready var button: Button = $Button
@onready var card_ui: NinePatchRect = $CardUI

# Load your sprite sheet
var deck_texture: Texture2D = preload("res://assets/cards/Cards_sheet.jpg")

# Size of each card in the sheet (in pixels)
const CARD_WIDTH = 616.0
const CARD_HEIGHT = 824.0

# Number of columns and rows in the sheet
const COLS = 13
const ROWS = 4

func _ready():
	texture = deck_texture
	#region_enabled = true

func _on_button_pressed():
	var col = randi() % COLS
	print(col)
	print("apasat")
	var row = randi() % ROWS
	print(row)
	region_rect = Rect2(col * CARD_WIDTH, row * CARD_HEIGHT, CARD_WIDTH, CARD_HEIGHT)
