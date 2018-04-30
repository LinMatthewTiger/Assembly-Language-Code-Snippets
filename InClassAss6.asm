# Matthew Lin B01211593
# In Class assignment 6

.data
Message1:	.asciiz "Welcome to my first function call in Assembly.\n"	# Make messages and store them in variables
Message2:	.asciiz "Enter an integer to double: "
Message3:	.asciiz "The number you entered doubled is: "
Message4:	.asciiz "\nGoodbye!\n"
a: 		.word 0
.text
lw	$a0,a		

jal Introduction
jal Prompt
move 	$a0, $v0		# Moves Number to double to $a0
jal Doubled
move	$a1, $a0		# Moves doubled number to $a1
jal Display
j Exit

Introduction:
	li	$v0,4		# load intermediate 4 for asciiz
	la	$a0, Message1	# load address
	syscall			# Print message
	jr $ra			# Returns the function
Prompt:
	li	$v0,4		# load intermediate 4 for asciiz
	la	$a0, Message2	# load address
	syscall			# Print message
	li	$v0, 5		# Assigns input to $v0
	syscall
	jr $ra			# Returns the function
Doubled:
	sll $a0, $a0, 1		# Calculates number doubled
	jr $ra 			# Returns the function

Display:
	la	$a0, Message3
	li 	$v0, 4
	syscall			# Prints Message3
	move	$a0, $a1
	li	$v0,1
	syscall			# Prints number
	jr $ra			# Returns the function
Exit:
	li	$v0,4		# load intermediate 4 for asciiz
	la	$a0, Message4	# load address
	syscall			# Print message
	li	$v0, 10		# Close Program
	syscall