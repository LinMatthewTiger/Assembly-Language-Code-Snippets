# Matthew Lin  B01211593
# In Class Assignment 5

.data
	displayMSG:	.asciiz "Enter String: " # Save messages
	displayInt:	.asciiz "Enter an Integer: "
	displayExit:	.asciiz "Exiting"
	inString:	.space	25	# Reserve spot for string
	MaxChar:	.word	25
	Exit: 		.word	-1	# Make Necessary Declarations
	Zero:		.word	0
	
.text
	lw	$t0, Zero	# Make Necessary Declarations
	lw	$t3, Exit
	
Input:
	la	$a0, displayMSG		# Dispaly String Prompt
	li	$v0, 4
	syscall
	la	$a0, inString
	lw	$a1, MaxChar
	li 	$v0, 8			# Assigns input to inString
	syscall
	la	$a0, displayInt		# Display Integer Prompt
	li	$v0,4
	syscall
	li	$v0, 5			# Assigns input to $v0
	syscall
	move 	$t0, $v0		# Assigns input to $t0
	beq	$t3, $t0, Exits		# Jumps to Exits if integer is -1
	li	$t1, 0			# Resets counter
	j	Output			# Jumps to Output
	
	
Output:
	slt $t2, $t1, $t0	# Makes criteria $t1 < $t0
	beq $t2, $zero, Input	# If $t1 < $t0 is false, go to Exits
	li	$v0,4		# Print message
	la	$a0, inString	
	syscall			
	addi $t1,$t1,1		# add 1 to $t1
	j Output		# jump back to Output

Exits: 
	la	$a0, displayExit	# Display Exiting
	li	$v0, 4
	syscall	
	li	$v0, 10			# End Program
	syscall