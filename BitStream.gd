tool

class_name BitStream

var data: PoolByteArray

var cursor: int

func clear() -> void:
	data = []
	cursor = 0

func get_bit_position() -> int:
	return cursor % 8

func get_byte_position() -> int:
	# warning-ignore:integer_division
	return cursor / 8
