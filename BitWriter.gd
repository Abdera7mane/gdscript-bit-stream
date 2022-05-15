tool

class_name BitWriter extends BitStream

func write(value: int, bits: int) -> void:
	if bits <= 0 or bits > 64:
		push_error("Invalid bit size")
	
	var remaining: int = bits
	
	while remaining > 0:
		var byte_index: int = get_byte_position()
		if data.size() == byte_index:
			data.insert(byte_index, 0)
		
		var bit_index: int = get_bit_position()
		var bits_left: int = 8 - bit_index
		var bit_count: int = remaining if remaining <= bits_left else bits_left
		
		data[byte_index] |= (value & 0xFF) << bit_index
		
		value >>= bit_count
		remaining -= bit_count
		cursor += bit_count

func write_bit(bit: bool) -> void:
	write(bit, 1)

func write_byte(byte: int) -> void:
	write(byte, 8)

func write_buffer(buffer: PoolByteArray) -> void:
	if get_bit_position() == 0:
		data.append_array(buffer)
		cursor += buffer.size() * 8
		return
	
	for byte in buffer:
		write_byte(byte)
