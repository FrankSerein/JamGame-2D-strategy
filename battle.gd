extends Node2D


@onready var grid = $Grid
@onready var player = $PlayerCharacter
@onready var turn_label: Label = $UI/TurnLabel


var player_selected := false


func _ready() -> void:
	turn_label.text = "TURN 1    PLAYER PHASE"

	player.setup(Vector2i(3, 4))


func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:

			var mouse_pos: Vector2 = get_global_mouse_position()

			var cell: Vector2i = grid.world_to_cell(mouse_pos)

			if not grid.is_inside(cell):
				return

			# Click player
			if cell == player.grid_position:

				player_selected = true

				grid.selected_cell = cell

				grid.movement_cells = grid.get_movement_range(
					player.grid_position,
					player.move_range
				)

				grid.queue_redraw()

				return

			# Move player
			if player_selected and cell in grid.movement_cells:

				player.grid_position = cell

				var target_position: Vector2 = grid.cell_to_world(cell)

				player.position = grid.to_global(target_position)

				player_selected = false

				grid.selected_cell = Vector2i(-1, -1)
				grid.movement_cells.clear()

				grid.queue_redraw()
