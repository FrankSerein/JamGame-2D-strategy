extends CharacterBody2D


const TILE_SIZE: int = 64

var grid_position: Vector2i = Vector2i.ZERO
var move_range: int = 4


func setup(start_position: Vector2i) -> void:
	grid_position = start_position

	position = Vector2(
		grid_position.x * TILE_SIZE + TILE_SIZE / 2,
		grid_position.y * TILE_SIZE + TILE_SIZE / 2
	)
