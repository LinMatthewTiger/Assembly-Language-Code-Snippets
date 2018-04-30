# Matthew Lin
# In Class Assignment 9

.data 
g:	.word 10		# Variable Declarations
h:	.word 15
i:	.word 3
k: 	.word 2
test:	.word 56
message1:	.asciiz "\n Returned Value = "
message2: 	.asciiz "\n s0 = "

.text
lw $a0, g		# Load into registers
lw $a1, h
lw $a2, i
lw $a3, k
lw $s0, test

addi $sp, $sp, -4	# Put $s0 original value in stack
sw $s0, 0($sp)	

jal sum_proc		# Jump to procedure sum_proc

move $t0, $v0		# Print Sum
li $v0, 4
la $a0, message1
syscall
move $a0, $t0
li $v0, 1
syscall

addi $sp, $sp, 4	# Pop $s0 original value
lw $s0, 0($sp)	
addi $sp, $sp, 4
lw $s0, 0($sp)	

li $v0, 4
la $a0, message2
syscall
move $a0, $s0		# Print $s0
li $v0, 1
syscall

j Exit		# Jump to Exit



sum_proc:
	add $s1, $a0, $a1		# f = (g+h)
	addi $sp, $sp, -4
	sw $s1, 0($sp)			# Store in stack
	add $s2, $a2, $a3		# k = (i + j)*2
	sll $s2, $s2, 1			
	addi $sp, $sp, -4
	sw $s2, 0($sp)			# Store in stack
	add $s0, $s1, $s2		# Sum = (f + k)   (Using $s0 again)
	addi $sp, $sp, -4
	sw $s0, 0($sp)			# Store sum in stack
	lw $v0, 0($sp)			# Pop Sum from stack
	addi $sp, $sp, 4
	jr $ra

Exit:
	li	$v0, 10		# Close Program
	syscall

	
	