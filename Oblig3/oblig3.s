	// imports fread and fwrite
	// disse kan kalles på med call _fwrite
	.extern	fread, fwrite

	.text
	.globl	readbyte
 # Navn:	readbyte
 # Synopsis:	Leser en byte fra en binærfil.
 # C-signatur: 	int readbyte (FILE *f)
 # Registre:

readbyte:
	pushl	%ebp		# Standard funksjonsstart
	movl	%esp,%ebp	#

	// call dumpreg
	movl $0, 12(%ebp)
	leal  12(%ebp),%edx
	pushl	8(%ebp)		#file
	pushl $1				#nmemb
	pushl $1				#size
	pushl %edx			#pointer to what to read
	call fread		#returns a pointer to eax
	// call dumpreg

	cmpl $0, %eax		#check if end of line
	je error
	movl 12(%ebp), %eax
	movl %ebp, %esp
	popl	%ebp		# Standard
	ret			# retur.

error:
	movl $-1, %eax
	movl %ebp, %esp
	popl	%ebp		# Standard
	ret			# retur.

	.globl	readutf8char
 # Navn:	readutf8char
 # Synopsis:	Leser et Unicode-tegn fra en binærfil.
 # C-signatur: 	long readutf8char (FILE *f)
 # Registre:

readutf8char:
	pushl	%ebp		# Standard funksjonsstart
	movl	%esp,%ebp	#
	#needs to check how manny bytes
	// movl 12(%ebp), %eax
	subl	$8,%esp
	pushl 8(%ebp)
	call readbyte
	movl %eax, %edx

	// andl $0xc0, %eax
	// cmpl $0x80, %eax
	// je other

	cmpl $0xc0,%edx
	jl ru8_1byte
	//check if starts with 0b10xxxxxx

	cmpl $0xe0,%edx
	jl ru8_2byte
//
	cmpl $0xf0,%edx
	jl ru8_3byte
//
	jmp ru8_4byte

ru8_1byte:
	movl %edx, %eax
	jmp	exit

ru8_2byte:
	// call dumpreg
	andl $0x1F, %eax
	// movl %edx, %esi
	sall $6, %eax
	// call dumpreg
	movl %eax, 16(%ebp)
	subl	$8,%esp
	pushl 8(%ebp)
	call readbyte
	andl $0x3F, %eax
	orl 16(%ebp), %eax
	// call dumpreg

	jmp	exit

ru8_3byte:
	andl $0xF, %eax
	// movl %edx, %esi
	sall $12, %eax
	// movl %eax, %edi
	movl %eax, 16(%ebp)
	// call dumpreg

	subl	$8,%esp
	pushl 8(%ebp)
	call readbyte
	andl $0x3F, %eax
	sall $6, %eax
	orl 16(%ebp), %eax
	// call dumpreg

	movl %eax, 16(%ebp)

	subl	$8,%esp
	pushl 8(%ebp)
	call readbyte
	andl $0x3F, %eax
	orl 16(%ebp), %eax
	// call dumpreg


	// call dumpreg
	jmp	exit

ru8_4byte:
	andl $0xF, %eax
	// movl %edx, %esi
	sall $18, %eax
	// movl %eax, %edi
	movl %eax, 16(%ebp)
	// call dumpreg

	subl	$8,%esp
	pushl 8(%ebp)
	call readbyte
	andl $0x3F, %eax
	sall $12, %eax
	orl 16(%ebp), %eax
	// call dumpreg
	movl %eax, 16(%ebp)

	subl	$8,%esp
	pushl 8(%ebp)
	call readbyte
	andl $0x3F, %eax
	sall $6, %eax
	orl 16(%ebp), %eax
	// call dumpreg
	movl %eax, 16(%ebp)

	subl	$8,%esp
	pushl 8(%ebp)
	call readbyte
	andl $0x3F, %eax
	orl 16(%ebp), %eax
	// call dumpreg

	jmp	exit

// other:
// call dumpreg
// 	andl $0x3f, %edx
// 	movl %edx, %eax
//
// 	jmp exit



	.globl	writebyte
 # Navn:	writebyte
 # Synopsis:	Skriver en byte til en binærfil.
 # C-signatur: 	void writebyte (FILE *f, unsigned char b)
 # Registre:

writebyte:
		pushl	%ebp					 	# Standard funksjonsstart
		movl	%esp,%ebp

		leal 	12(%ebp),%eax		# pointer of second argument
		pushl	8(%ebp)
		pushl $1
		pushl $1
		pushl %eax
		call	fwrite

		movl %ebp, %esp
		popl	%ebp						# Standard restore the base pointer
		ret


	.globl	writeutf8char
 # Navn:	writeutf8char
 # Synopsis:	Skriver et tegn kodet som UTF-8 til en binærfil.
 # C-signatur: 	void writeutf8char (FILE *f, unsigned long u)
 # Registre:

writeutf8char:
	pushl	%ebp		# Standard funksjonsstart
	movl	%esp,%ebp	#
	#needs to check how manny bytes
	// movl 12(%ebp), %eax
	movl 12(%ebp), %edx

	cmpl $0x80,%edx
	jl wu8_1byte
	//
	cmpl $0x800,%edx
	jl wu8_2byte
	//
	cmpl $0x10000,%edx
	jl wu8_3byte
	//
	cmpl $0x10000,%edx
	jge wu8_4byte

	jmp exit

wu8_1byte:
	pushl %edx
	pushl 8(%ebp)
	call writebyte
	jmp	exit


wu8_2byte:
	// maskes med  110xxxxx10xxxxxx
//edx is used to store backup

	// 1101111110111111

	movl %edx, %ebx
	// //flytte til hoyre
	// call dumpreg
	sarl $6, %ebx
	// movl
	andl $0xDF, %ebx
	orl $0xc0, %ebx
	// call dumpreg

	pushl %ebx
	pushl 8(%ebp)
	call writebyte

	movl 12(%ebp), %edx
	// andl $0xbf, %edx
	// orl $0x80, %edx
	//
	//
	// pushl %edx
	// pushl 8(%ebp)
	// call writebyte


	pushl %edx
	pushl 8(%ebp)
	call uniscode

	jmp	exit

wu8_3byte:
	movl %edx, %ebx
	// //flytte til hoyre
	// call dumpreg
	sarl $12, %ebx
	// movl
	andl $0xEF, %ebx
	orl $0xE0, %ebx
	// call dumpreg

	pushl %ebx
	pushl 8(%ebp)
	call writebyte

	movl 12(%ebp), %edx
	// andl $0xbf, %edx
	// orl $0x80, %edx
	//
	//
	// pushl %edx
	// pushl 8(%ebp)
	// call writebyte

	sarl $6, %edx

	pushl %edx
	pushl 8(%ebp)
	call uniscode

	movl 12(%ebp), %edx


	pushl %edx
	pushl 8(%ebp)
	call uniscode

	jmp	exit

wu8_4byte:
movl %edx, %ebx
// //flytte til hoyre
// call dumpreg
sarl $18, %ebx
// movl
andl $0xF7, %ebx
orl $0xf0, %ebx
// call dumpreg

pushl %ebx
pushl 8(%ebp)
call writebyte

movl 12(%ebp), %edx
sarl $12, %edx
pushl %edx
pushl 8(%ebp)
call uniscode

movl 12(%ebp), %edx
sarl $6, %edx
pushl %edx
pushl 8(%ebp)
call uniscode

movl 12(%ebp), %edx
pushl %edx
pushl 8(%ebp)
call uniscode

jmp	exit

exit:
	movl %ebp, %esp
	popl	%ebp		# Standard
	ret			# retur.

		.globl uniscode

uniscode:
		pushl	%ebp		# Standard funksjonsstart
		movl	%esp,%ebp	#

		andl $0xbf, %edx
		orl $0x80, %edx

		pushl %edx
		pushl 8(%ebp)
		call writebyte


		movl %ebp, %esp
		popl	%ebp		# Standard
		ret			# retur.
