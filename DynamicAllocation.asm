# Matthew Lin
# B01211593

.text

	li $v0, 9		#Allocation a block of memeory
	li $a0, 4		#Allocate 4 bytes
	syscall			
	
	move $s0, $v0		# Save the retured pointer in memory
	li $t0, 77		# $t0 = 77
	sw $t0, 0($s0)		# Store $t0 into dynamically allocated memory
	
	lw $a0, 0($s0)		# Load value from memory into reigster $a0
	li $v0, 1		# Output integer
	syscall			
	
	li $v0, 10
	syscall