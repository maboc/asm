rekentuig : rekentuig.o schrijfhulp.o
	ld  -m elf_x86_64 -o rekentuig rekentuig.o schrijfhulp.o

rekentuig.o : rekentuig.asm
	nasm -f elf64 -gdwarf rekentuig.asm

schrijfhulp.o : schrijfhulp.asm
	nasm -f elf64 -gdwarf schrijfhulp.asm

clean :
	rm *.o
	rm *.*~
	rm *~
