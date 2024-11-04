/*
 * Copyright (C) 2000, Jan-Derk Bakker (J.D.Bakker@its.tudelft.nl)
 * Copyright (C) 2008, BusyBox Team. -solar 4/26/08
 * Licensed under GPLv2 or later, see file LICENSE in this source tree.
 */

#define _GNU_SOURCE 1 /* for strchrnul */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <errno.h>
#include <string.h>
#include <ctype.h>
#include <inttypes.h> //strchrnul

#define FATAL(str) do { \
	fprintf(stderr, "<%s> Error at line %d, file %s (%d) [%s]\n", \
			str, __LINE__, __FILE__, errno, strerror(errno)); \
	exit(1); \
} while(0)

static void bb_show_usage()
{
	printf("dump from physical address\n\n");
	printf("Usage: dump_4k_mem ADDRESS\n");
	printf("\n");
	exit(1);
}

static void my_print_hex_dump(void *addr, int prefix_type, unsigned int size)
{
	int i, j, k;
	char *buf = (char *)addr;
	ssize_t print_size = 0, ascii_size = 0;
	char print_buf[512] = {0}, ascii_buf[32] = {0};
	unsigned long temp_addr;

	if (prefix_type == 1) {
		//DUMP_PREFIX_ADDRESS=1
		temp_addr = (unsigned long)addr;
	} else {
		//DUMP_PREFIX_OFFSET=2
		temp_addr = 0;
	}

	print_size = 0;
	memset(print_buf, 0, sizeof(print_buf));
	print_size+=sprintf(print_buf+print_size, "\t  ");
	for (i = 0; (i < 16 && i < size); i+=4) {
		print_size+=sprintf(print_buf+print_size, "%08x", i);
		print_size+=sprintf(print_buf+print_size, " ");
	}
	printf("%s\n", print_buf);

	for (j = 0; j < size; j += 16) {
		print_size = 0;
		ascii_size = 0;
		memset(print_buf, 0, sizeof(print_buf));
		print_size+=sprintf(print_buf+print_size, "%08lx: ", temp_addr + j);

		for (i = 0; (i < 16 && i < size); i+=4) {
			for (k = 3; k >= 0; k--) {
				print_size+=sprintf(print_buf+print_size, "%02X", buf[j + i + k] & 0xff);
			}
			for (k = 0; k <= 3; k++) {
				if((buf[j + i + k] & 0xff) < ' ' || (buf[j + i + k] & 0xff) > '~') {
					ascii_size+=sprintf(ascii_buf+ascii_size, ".");

				} else {
					ascii_size+=sprintf(ascii_buf+ascii_size, "%c", buf[j + i + k] & 0xff);
				}
			}
			print_size+=sprintf(print_buf+print_size, " ");

		}
		print_size+=sprintf(print_buf+print_size, "  %s\n", ascii_buf);

		printf("%s", print_buf);
	}
	return;
}

int main(int argc, const char *argv[])
{
	void *map_base, *virt_addr;
	uint64_t read_result;
	off_t target;
	unsigned page_size, mapped_size, offset_in_page;
	int fd;
	unsigned width = 8 * sizeof(int);

	/* devmem ADDRESS */

	/* ADDRESS */
	if (!argv[1])
		bb_show_usage();
	errno = 0;
	target = strtoull(argv[1], NULL, 0); /* allows hex, oct etc */

	if (errno)
		bb_show_usage(); /* one of bb_strtouXX failed */

	fd = open("/dev/mem", O_RDONLY | O_SYNC);
	mapped_size = page_size = getpagesize();
	offset_in_page = (unsigned)target & (page_size - 1);
	if (offset_in_page + width > page_size) {
		/* This access spans pages.
		 * Must map two pages to make it possible: */
		mapped_size *= 2;
	}
	map_base = mmap(NULL,
			mapped_size,
			PROT_READ,
			MAP_SHARED,
			fd,
			target & ~(off_t)(page_size - 1));
	if (map_base == MAP_FAILED)
		FATAL("mmap");


	virt_addr = (char*)map_base + offset_in_page;

	printf("Memory mapped at address %p, virt_addr=%p.\n", map_base, virt_addr);

	my_print_hex_dump(virt_addr, 0, mapped_size);

	if (munmap(map_base, mapped_size) == -1)
		FATAL("munmap");
	close(fd);

	return EXIT_SUCCESS;
}
