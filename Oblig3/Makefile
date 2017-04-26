

run: compile
	./testnig

compile:
	gcc -m32 oblig3.s main.c -o testnig -std=c99

clean:
	rm -r *.txt
	rm -r testnig
	rm -r writebytes.s

test:
	gcc -S writebytes.c -o writebytes.s -std=c99

test2:
	gcc -m32 oblig3.s test-oblig3.c -o testnig -std=c99 -g
	./testnig
