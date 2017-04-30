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

pushl 8(%ebp)
call readbyte
movl %eax, %edx

cmpl $0x80,%edx
jl ru8_1byte
//
cmpl $0x800,%edx
jl ru8_2byte
//
cmpl $0x10000,%edx
jl ru8_3byte
//
cmpl $0x10000,%edx
jge ru8_4byte


ru8_1byte:
jmp	exit


ru8_2byte:

jmp	exit

ru8_3byte:

jmp	exit

ru8_4byte:

jmp	exit

exit:
movl %ebp, %esp
popl	%ebp		# Standard
ret			# retur.



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


wu8_1byte:
	pushl %edx
	pushl 8(%ebp)
	call writebyte
	jmp	exit


wu8_2byte:

	jmp	exit

wu8_3byte:

	jmp	exit

wu8_4byte:

	jmp	exit

exit:
	movl %ebp, %esp
	popl	%ebp		# Standard
	ret			# retur.
