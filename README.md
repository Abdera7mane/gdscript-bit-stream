# GDScript Bit Stream

Bit-level data stream for [Godot Engine](https://github.com/godotengine/godot) to write/read an arbitrary number of bits (from 1-bit to 64-bit), the bits are stored/retrieved in the [least significant bit](https://en.wikipedia.org/wiki/Least_significant_bit) order (LSB).

## Example

```gdscript
func example_write() -> PoolByteArray:
    var writer: = BitWriter.new()
    
    # Write a 4-bit integer
    writer.write(15, 4)
    
    # Write a 12-bit integer
    writer.write(3000, 12)
    
    return writer.data

func example_read(data: PoolByteArray) -> void:
    var reader: = BitReader.new()
    reader.data = data
    
    # Reads a 4-bit integer
    var value1: int = reader.read(4)
    # Reads a 12-bit integer
    var value2: int = reader.read(12)
    
    assert(value1 == 15)
    assert(value2 == 3000)

func example():
    var data: = example_write()
    example_read(data)

```

## Documentation

### Class: BitStream

Inherits: [Reference](https://docs.godotengine.org/en/3.4/classes/class_reference.html) < [Object](https://docs.godotengine.org/en/3.4/classes/class_object.html)  
Inherited by: [BitReader](#class-bitreader), [BitWriter](#class-bitwriter)

#### Description

Abstract and base class for bit-level data streams

#### Properties

| type                                                                                  | name                  | description                                   |
|---------------------------------------------------------------------------------------|-----------------------|-----------------------------------------------|
| [PoolByteArray](https://docs.godotengine.org/en/3.4/classes/class_poolbytearray.html) | data                  | contains the data in bytes                    |
| [int](https://docs.godotengine.org/en/3.4/classes/class_int.html)                     | cursor                | the current bit index in the whole data array |

#### Methods

| return type                                                                           | definition            | description                                   |
|---------------------------------------------------------------------------------------|-----------------------|-----------------------------------------------|
| void                                                                                  | clear()               | clear the data stream                         |
| [int](https://docs.godotengine.org/en/3.4/classes/class_int.html)                     | get_bit_position()    | get the index of the current byte's bit       |
| [int](https://docs.godotengine.org/en/3.4/classes/class_int.html)                     | get_byte_position()   | get the index of the current byte             |

----

### Class: BitReader

Inherits: [BitStream](#class-bitstream) < [Reference](https://docs.godotengine.org/en/3.4/classes/class_reference.html) < [Object](https://docs.godotengine.org/en/3.4/classes/class_object.html)

#### Description

Reading implementation of the **BitStream** class, reading operations will increment `cursor` by the number of read bits

#### Methods
| return type                                                         | definition             | description                                             |
|---------------------------------------------------------------------|------------------------|---------------------------------------------------------|
| [int](https://docs.godotengine.org/en/3.4/classes/class_int.html)   | read(bits: int)        | reads the next `bits` as an integer value               |
| [bool](https://docs.godotengine.org/en/3.4/classes/class_bool.html) | read_bit()             | reads 1 bit as a boolean value, equivalant of `read(1)` |
| [int](https://docs.godotengine.org/en/3.4/classes/class_int.html)   | read_byte()            | reads the next 8 bits, equivalant of `read(8)`          |
| [PoolByteArray](https://docs.godotengine.org/en/3.4/classes/class_poolbytearray.html) | read_buffer(size: int) | reads the next `size * 8` of bits     |

----

### Class: BitWriter

Inherits: [BitStream](#class-bitstream) < [Reference](https://docs.godotengine.org/en/3.4/classes/class_reference.html) < [Object](https://docs.godotengine.org/en/3.4/classes/class_object.html)

#### Description

Writing implementation of the **BitStream** class, writing operations will increment the `cursor` by the number of written bits

#### Methods
| return type | definition                          | description                                                |
|-------------|-------------------------------------|------------------------------------------------------------|
| void        | write(value: int, bits: int)        | writes an integer in the number of `bits`                  |
| void        | write_bit(bit: bool)                | writes a boolean in 1 bit, equivalent of `write(value, 1)` |
| void        | write_byte(byte: int)               | writes an 8 bits integer, equivalent of `write(value, 8)`  |
| void        | write_buffer(buffer: PoolByteArray) | writes an array of bytes                                   |

