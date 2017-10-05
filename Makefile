rekentuig : rekentuig.o
	ld -o rekentuig rekentuig.o

rekentuig.o : rekentuig.asm
	nasm -f elf64 -g rekentuig.asm

clean :
	rm *.o
	rm *.*~
	rm *~
