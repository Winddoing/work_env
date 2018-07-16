#
# Makefile for irom utils.
#

all: bin_to_8bit_hex bin_to_32bit_hex bin_to_32bit_bin	gen_rom_crc hex2bin
	
	gcc -o bin_to_8bit_hex bin_to_8bit_hex.c
	gcc -o bin_to_32bit_hex bin_to_32bit_hex.c
	gcc -o bin_to_32bit_bin bin_to_32bit_bin.c
	gcc -o gen_rom_crc gen_rom_crc.c
	gcc -o hex2bin hex2bin.c

clean:
	rm -f bin_to_8bit_hex bin_to_32bit_hex bin_to_32bit_bin	gen_rom_crc hex2bin
