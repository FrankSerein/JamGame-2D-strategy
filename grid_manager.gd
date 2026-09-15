extends Node2D


const TILE_SIZE: int = 64
const GRID_WIDTH: int = 12
const GRID_HEIGHT: int = 8

var selected_cell: Vector2i = Vector2i(-1, -1)
var movement_cells: Array[Vector2i] = []


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	for y in range(GRID_HEIGHT):
		for x in range(GRID_WIDTH):

			var cell := Vector2i(x, y)

			var rect := Rect2(
				x * TILE_SIZE,
				y * TILE_SIZE,
				TILE_SIZE,
				TILE_SIZE
			)

			# Normal tile
			var color := Color(0.15, 0.15, 0.18)

			# Movement range
			if cell in movement_cells:
				color = Color(0.1, 0.35, 0.8)

			# Selected tile
			if cell == selected_cell:
				color = Color(0.2, 0.8, 1.0)

			draw_rect(rect, color, true)

			draw_rect(
				rect,
				Color(0.05, 0.05, 0.05),
				false,
				2.0
			)


func world_to_cell(pos: Vector2) -> Vector2i:
	var local_pos: Vector2 = to_local(pos)

	return Vector2i(
		floor(local_pos.x / TILE_SIZE),
		floor(local_pos.y / TILE_SIZE)
	)


func cell_to_world(cell: Vector2i) -> Vector2:
	return Vector2(
		cell.x * TILE_SIZE + TILE_SIZE / 2,
		cell.y * TILE_SIZE + TILE_SIZE / 2
	)


func is_inside(cell: Vector2i) -> bool:
	return (
		cell.x >= 0
		and cell.x < GRID_WIDTH
		and cell.y >= 0
		and cell.y < GRID_HEIGHT
	)


func get_movement_range(origin: Vector2i, movement: int) -> Array[Vector2i]:

	var result: Array[Vector2i] = []

	for y in range(GRID_HEIGHT):
		for x in range(GRID_WIDTH):

			var cell := Vector2i(x, y)

			var distance: int = abs(cell.x - origin.x) + abs(cell.y - origin.y)

			if distance <= movement:
				result.append(cell)

	return result
