# Matthew Lin B01211593
# In Class assignment 7

.data
Message1:	.asciiz "Enter a String: \n"	# Make messages and store them in variables
Message2:	.asciiz "String Length is: "	
myString: 	.space 100
MaxChar:	.word 100
Length:		.word 0
nullTerm:	.byte '0'
newLine: 	.byte '\n'
.text
lb	$t5, nullTerm	#Declarations
lb	$t4, newLine

li	$v0,4		# load intermediate 4 for asciiz
la	$a0, Message1	# load address
syscall

la	$a0, myString
lw	$a1, MaxChar
li 	$v0, 8		# Assigns input to myString
syscall

la	$a0, myString
li	$v0,4		# Print message
syscall	

jal strlen

jal trimNewline

jal strlen

li $v0,4		# load intermediate 4 for asciiz
la $a0, Message2	# load address
syscall

move $a0, $t2
li $v0,1
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
	
Exit:
	li	$v0, 10		# Close Program
	syscall