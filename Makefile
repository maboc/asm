rekentuig : rekentuig.o
	ld  -m elf_x86_64 -o rekentuig rekentuig.o

rekentuig.o : rekentuig.asm
	nasm -f elf64 -gdwarf rekentuig.asm

clean :
	rm *.o
	rm *.*~
	rm *~
