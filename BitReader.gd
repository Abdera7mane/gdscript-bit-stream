tool

class_name BitReader extends BitStream

func read(bits: int) -> int:
	if bits <= 0 or bits > 64:
		push_error("Invalid bit size")
		return 0
	
	var value: int = 0
	
	if bits < 0:
		return value
	
	var remaining: int = bits
	var shift: int
	
	while remaining > 0:
		var byte_index: int = get_byte_position()
		var bit_index: int = get_bit_position()
		var bits_left: int = 8 - bit_index
		var bit_count: int = remaining if remaining <= bits_left else bits_left
		
		value |= (data[byte_index] >> bit_index) << shift
		
		shift += bit_count
		remaining -= bit_count
		cursor += bit_count
	
	return value

func read_bit() -> bool:
	return bool(read(1))

func read_byte() -> int:
	return read(8)

func read_buffer(size: int) -> PoolByteArray:
	var buffer: PoolByteArray = []
	if get_bit_position() == 0:
		var byte_index: int = get_byte_position()
		buffer = data.subarray(byte_index, byte_index + size - 1)
		cursor += buffer.size() * 8
	else:
		for i in size:
			buffer.append(read_byte())
	
	return buffer
