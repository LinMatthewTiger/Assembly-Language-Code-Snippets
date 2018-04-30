# Matthew Lin B01211593
# In Class Assignment 10

.data 
x:	.word 0		# Variable Declarations
message1:	.asciiz "\nPlease enter an integer: "
message2: 	.asciiz "\nReturned value: "

.text	
li $v0, 4
la $a0, message1	# Print Message 1
syscall
li $v0, 5		# Obtain an X value
syscall
move $a0, $v0		# Store in $a0
li $v0, 0		# Reset $v0 for use in recursion

jal add_r		# Jump to add_r

move $t0, $v0		# Save $v0
li $v0, 4
la $a0, message2	# Print Message 2
syscall
move $a0, $t0	
li $v0, 1		# Print Value
syscall

j Exit			# Exit 

add_r:					# Recursive Function
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	addi $sp, $sp, -4
	sw $a0, 0($sp)
	bgt $a0, $zero, recur		# Decrement value until it's equal to zero
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	
recur:
	addi $a0, $a0, -1		# Decrement value 
	jal add_r
	
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	add $v0, $a0, $v0		# Add Values
	
	jr $ra
	

Exit:
li $v0, 10		# Close Program
syscall