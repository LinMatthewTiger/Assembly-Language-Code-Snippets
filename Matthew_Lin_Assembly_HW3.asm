# Matthew Lin  B01211593
# Homework 3

.data
	A: 	.word	1,2,3,4,5,6,7,8,9,10 	# 10 integers
	B: 	.word 	1,1,1,1,5,5,5,8,8,8	 # 10 integers
	C: 	.word 	-1,-1,-1,-1,-1,-1,-1,-1,-1,-1 	# 10 integers
	Count:	.word	0	# Counter for matches
	
.text
	li	$t0, 10
	la	$s0, A
	la	$s1, B
	la 	$s2, C
	li 	$s3, 0
	li	$s4, 0
	lw	$s5, Count
	
Loop_A:
	bge $t1, $t0, Exit	# Exits when all contents of A have been checked
	li $t2, 0
	sll $t2, $t1, 2
	add $t2,$t2,$s0
	lw $s3, ($t2)
	addi $t1, $t1, 1	# Increments for Outer loop
	li $t3, 0		# Resets increment for inner loop
	j Loop_B		# Jump to inner loop
	
Loop_B:
	bge $t3, $t0, Loop_A	# Jumps to outer loop at end of array B
	li $t4, 0
	sll $t4, $t3, 2
	add $t4,$t4,$s1	
	lw $s4, ($t4)		
	beq $s3,$s4,C_Stuff	# Jumps to increment count if match found
	addi $t3, $t3, 1	# Increment for inner loop
	j Loop_B		# Jumps back to inner loop
		
C_Stuff:
	li $t6, 0		# Saves A[i] = C[i]
	add $t6, $t2, $s2
	sw $s2, ($t2)
	addi $s5, $s5, 1	# Incremets count
	j Loop_A		# Jumps back to Outer Loop
	
Exit:
	sw $s5, Count		# Output Count
	li $v0, 1
	lw $a0, Count
	syscall 