#Matthew Lin B01211593
#Assignment 4 (Switch)

.data
	k:		.word 3
	a:      	.word 0
	b:      	.word 10
	c:	 	.word 5
	d:		.word 8
	e:		.word 7
	f:		.word 0
	
	
.text
	lw $s1,k  	   	# Load k into $s1
	lw $s2,a  		# Load a into $s2
	lw $s3,b  		# Load b into $s3
	lw $s4,c  		# Load c into $s4
	lw $s5,d  		# Load d into $s5
	lw $s6,e 		# Load e into $s6
	li $t0,0		# Load case values into temporary
	li $t1,1
	li $t2,2
	li $t3,3
	
Check:
	beq $t0, $s1, Case0  	# Jump to assiged case, jump to print if no case match is found
	beq $t1, $s1, Case1 
	beq $t2, $s1, Case2
	beq $t3, $s1, Case3
	b Print
	
	
Case0:
	add $s2, $s3, $s4	# Case 0: a = b + c
	b Print
	
Case1:
	add $s2, $s5, $s6	# Case 1: a = d + e
	b Print
	
Case2:
	sub $s2, $s5, $s6	# Case 2: a = d - e
	b Print
	
Case3: 
	sub $s2, $s3, $s4	# Case 3: a = b - c
	b Print
	
Print:				# Print a
	sw $s2, a
	li $v0, 1
	lw $a0, a
	syscall