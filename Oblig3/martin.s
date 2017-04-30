	.extern	fread, fwrite

	.text

#########################
# int readbyte(FILE *f) #
#########################
	.globl	readbyte
readbyte:
	pushl	%ebp		#
	movl	%esp,%ebp	#

	movl	$0,12(%ebp)	# initialize with 0
	leal	12(%ebp),%eax	# put address in eax
	pushl	8(%ebp)		# FILE *stream
	pushl	$1		# nmemb
	pushl	$1		# size
	pushl	%eax		# void *ptr
	call	fread

	cmp	$0,%eax		# if return is 0
	je	rb_e		# jump to error
	movl	12(%ebp),%eax	# return eax
	jmp	rb_x		# exit

rb_e:	movl	$-1,%eax	# return -1
	jmp	rb_x		# exit

rb_x:
	movl	%ebp,%esp	# restore esp
	popl	%ebp		#
	ret			#

##############################
# long readutf8char(FILE *f) #
##############################
	.globl	readutf8char
readutf8char:
	pushl	%ebp		#
	movl	%esp,%ebp	#

	subl	$8,%esp
	pushl	8(%ebp)
	call	readbyte

	movl	%ebp,%esp
	popl	%ebp		#
	ret			#

############################################
# void writebyte(FILE *f, unsigned char b) #
############################################
	.globl	writebyte
writebyte:
	pushl	%ebp		#
	movl	%esp,%ebp	#

	leal	12(%esp),%eax	# put address in eax
	pushl	8(%esp)		# FILE *stream
	pushl	$1		# nmemb
	pushl	$1		# size
	pushl	%eax		# void *ptr
	call	fwrite

	movl	%ebp,%esp
	popl	%ebp		#
	ret			#

################################################
# void writeutf8char(FILE *f, unsigned long u) #
################################################
	.globl	writeutf8char
writeutf8char:
	pushl	%ebp		#
	movl	%esp,%ebp	#

	

wu8_x:	popl	%ebp		#
	ret			#
