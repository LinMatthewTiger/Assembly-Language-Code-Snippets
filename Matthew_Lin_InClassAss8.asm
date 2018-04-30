# Matthew Lin B01211593
# In Class assignment 8

.data
Message1:	.asciiz "\nEnter a String: "	# Make messages and store them in variables
Message2:	.asciiz "String Length is: "	
Message3: 	.asciiz "\nCopied String is: "
myString: 	.space 100
data:		.space 100
CopiedString: 	.space 40
MaxChar:	.word 100
Length:		.word 0
nullTerm:	.byte '0'
newLine: 	.byte '\n'
.text
lb	$t5, nullTerm	#Declarations
li 	$t9, 100
lb	$t4, newLine
la	$a1, CopiedString

li	$v0,4		# load intermediate 4 for asciiz
la	$a0, Message1	# load address
syscall

la	$a0, myString
li 	$v0, 8		# Assigns input to myString
syscall

la	$a0, myString
li	$v0,4		# Print message
syscall	

jal strlen

jal trimNewline

jal strlen

jal strcpy

li $v0,4		# load intermediate 4 for asciiz
la $a0, Message2	# load address
syscall

move $a0, $t2		#Print length of string
li $v0,1
syscall

jal Open
jal Read
move $s1, $v0


li $v0, 4
la $a0, data
syscall

jal Exit

strlen:			#Counts items in the array

	add $t0,$t2,$a0		
	lb $t1, 0($t0)
	beq $t1,$t4, Escape	
	addi $t2, $t2, 1	#Increments counter
	j strlen
	
trimNewline:			#Trims the /n to a 0
	addi $t0,$t2,-1		#Decrements the index of array
	add $t1, $t0, $a0	#Stores location in array in $t1
	lb $t3, 0($t1)		#Puts byte in $t3
	bne $t3, $t4, Escape	#Escapes if it it's not /n
	sb $t5, 0($t1)		#Changes /n to 0
	jr $ra
	
Escape:
	jr $ra
	
strcpy: 
	add $t0, $t6, $a0	#Obtain index of input string
	lb $t3, 0($t0)		#Stores byte in $t3
	add $t1, $t6, $a1	#Obtain index of empty copied string
	sb $t3, 0($t1)		#Put byte in index of empty copied string
	beq $t6, $t2, Escape	#Break if equal to length of string
	addi $t6, $t6, 1	#Increment $t6
	j strcpy

Exit:
	li	$v0, 10		# Close Program
	syscall
	
Open:
# Open file
 li $v0, 13 # system call for open file
 la $a0, CopiedString # output file name
 li $a1, 0 # Open for writing (flags are 0: read, 1: write)
 li $a2, 0 # mode is ignored
 syscall # open a file (file descriptor returned in $v0)
 move $s6, $v0 # save the file descriptor
 jr $ra
 
Read:
 # Writing to file
 li $v0, 14 # system call for read to file
 move $a0, $s6 # file descriptor
 la $a1, data # address of input buffer from which to write
 move $a2, $t9 # read 100 characters long
 syscall 
 jr $ra