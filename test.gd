tool

extends EditorScript

var data: PoolByteArray

func _run() -> void:
	test_writer()
	test_reader()
	
	print(data)

func test_writer() -> void:
	var writer: = BitWriter.new()
	
	writer.write(15, 4)           # 0b1111                  writes a 4-bits integer
	writer.write_buffer([64, 32]) # 0b01000000 0b00100000   writes 2 bytes
	
	data = writer.data
	
	assert(data == PoolByteArray([0b00001111, 0b00000100, 0b0010]))
	

func test_reader() -> void:
	var reader: = BitReader.new()
	reader.data = data
	
	var value: int = reader.read(4)                   # reads a 4-bits integer
	var buffer: PoolByteArray = reader.read_buffer(2) # reads the next 2 bytes
	
	assert(value == 15)
	assert(buffer == PoolByteArray([64, 32]))
