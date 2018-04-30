# Matthew Lin
# Homework 5

.data
Message1:	.asciiz "\nEnter a string to convert to lowercase: "	# Make messages and store them in variables
Message2:	.asciiz "Number of translations is: "	
Message3: 	.asciiz "\nConverted string is: "
Message4:	.asciiz "\nEnter a string to convert to uppercase: "
myString: 	.space 100
CopiedString: 	.space 100
Check: 		.word 97
Changeupper: 	.word -32
Changelower: 	.word 32
newline:	.word 10
space:		.word 32
Symbols:	.word 64
.text
lw	$t6, Changelower	#Declarations
lw	$t4, Check
lw 	$t5, Changeupper
la	$a1, CopiedString
lw 	$t7, Symbols
lw 	$t8, newline


li	$v0,4		# Prompt for String to convert to lowercase
la	$a0, Message1	
syscall

la	$a0, myString
li 	$v0, 8		# Assigns input to myString
syscall

jal tolower		# Convert to lowercase procedure

la	$a0, Message2	# Display number of translations
li	$v0,4		
syscall	

move $a0, $t9
li $v0, 1
syscall

la	$a0, Message3	# Display converted string
li	$v0,4		
syscall	

la $a0, myString
li $v0, 4
syscall


li	$v0,4		# Prompt for String to convert to uppercase
la	$a0, Message4	
syscall

la	$a0, myString
li 	$v0, 8		# Assigns input to myString
syscall 

move $t9, $zero		# Resets counters
move $t0, $zero

jal toupper		# Convert to uppercase procedure

la	$a0, Message2	# Display number of translations
li	$v0,4		
syscall	

move $a0, $t9
li $v0, 1
syscall

la	$a0, Message3	# Display converted string
li	$v0,4		
syscall	

la $a0, myString
li $v0, 4
syscall

jal Exit		# Exit program

	
tolower:			
	add $t1, $t0, $a0	# Stores location in string in $t1
	lbu $t3, 0($t1)		# Puts byte in $t3
	addi $t0,$t0,1		# Increments the index of array
	blt $t3, $t8, Escape	# Escape if at end of string
	bge $t3, $t4, tolower	# Resets if not a uppercase letter
	blt $t3, $t7, tolower	# Resents if it is a symbol
	add $t3, $t3, $t6	# Changes to lowercase
	sb $t3, 0($t1)		# Stores back into string
	addi $t9, $t9, 1	# Increment counter for translations
	j tolower		# Jumps back to procedure
	
toupper:			
	add $t1, $t0, $a0	# Stores location in string in $t1
	lbu $t3, 0($t1)		# Puts byte in $t3
	addi $t0,$t0,1		# Increments the index of array
	beq $t3, $t8, Escape	# Escape if at end of string
	blt $t3, $t4, toupper	# Resets if not a lowercase letter
	add $t3, $t3, $t5	# Changes to uppercase
	sb $t3, 0($t1)		# Stores back into string
	addi $t9, $t9, 1	# Increment counter for translations
	j toupper		# Jumps back to procedure
	
Escape:
	jr $ra			# Exit procedure
	
Exit:
	li	$v0, 10		# Close Program
	syscall
