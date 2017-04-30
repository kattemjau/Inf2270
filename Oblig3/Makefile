

run: compile
	./testnig

compile: oblig3.s main.c
	gcc -m32 oblig3.s main.c -o testnig -std=c99 -g

clean:
	rm -rf *.txt
	rm -rf testnig
	rm -rf writebytes.s

test: writebytes.c
	gcc -S writebytes.c -o writebytes.s -std=c99 -g

test2: clean
	gcc -m32 oblig3.s dumpreg.s test-oblig3.c -o testnig -g
	./testnig
