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
// 	pushl	%ebp		# Standard funksjonsstart
// 	movl	%esp,%ebp	#
//
// 	pushl	8(%ebp)		#file
// 	pushl $1				#nmemb
// 	pushl $1				#size
// 	pushl %edx			#pointer to what to read
//
// 	call fread		#returns a pointer to eax
//
// 	cmpl $0, %eax
// 	jb error
// 	movl %edx, %eax
// 	movl %ebp, %esp
// 	popl	%ebp		# Standard
// 	ret			# retur.
//
// error:
// 	movl $-1, %eax
// 	movl %ebp, %esp
// 	popl	%ebp		# Standard
// 	ret			# retur.

pushl	%ebp						# Standard funksjonsstart
	movl	%esp,%ebp				#
	pushl $1
  leal  0(%esp),%edx
	pushl 8(%ebp)
	pushl $1 							# invalid push
	pushl $1
	pushl %edx
	call  fread
	movl  16(%esp), %edx

	addl 	$20, %esp
	cmpl  $0,%eax
	jbe   rb_error
	movl 	%edx,%eax
	jmp 	rb_x
rb_error:
	movl $-1, %eax
	popl %ebp
	ret


rb_x:
	popl	%ebp					# Standard
	ret									# retur.


	.globl	readutf8char
 # Navn:	readutf8char
 # Synopsis:	Leser et Unicode-tegn fra en binærfil.
 # C-signatur: 	long readutf8char (FILE *f)
 # Registre:

readutf8char:
	pushl	%ebp		# Standard funksjonsstart
	movl	%esp,%ebp	#

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

wu8_x:	popl	%ebp		# Standard
	ret			# retur.
