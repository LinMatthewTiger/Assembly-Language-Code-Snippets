# Matthew Lin
# B01211593
.data
message1:	.asciiz "Enter a base:  " 
message2: 	.asciiz "Enter a power: "
message3:	.asciiz "Error. Value too large! "
.text
# Nessesary variables
li $t1, 0
li $t2, 1
li $t3, 1

la $a0, message1	# Prompt for base
li $v0, 4
syscall

li $v0, 5		
syscall

move $t4, $v0		

la $a0, message2	# Prompt for the power
li $v0, 4
syscall

li $v0, 5		# 
syscall

move $a1, $v0		# Move values to appropriate registers
move $a0, $t4

li $v0,1

jal power		# Jump to procedure

move $a0, $v0		# Output value
li $v0, 1
syscall

jal Exit		# Exit program call

Exit:
li $v0, 10		# Exit program
syscall

power: 			# For loop for finding exponential values
bge $t0, $a1, Escape	# Branch if muliplied sufficent times
beq $a1, $t1, PowerIs1	# Branch if power is 0
addi $t0, $t0, 1	# Counter
mult $v0, $a0		# Actual multiplication
mfhi $t2		# High value
mflo $t3		# Low value
move $v0, $t3
bgt $t2,$zero,overflow	# Branch if value too large

j power			

Escape:			# Escape fucntion 
jr $ra

PowerIs1:		# Function if exponent is 0
li $v0, 1
jr $ra

overflow:		# Function for display overflow
move $a1, $v0
la $a0, message3	
li $v0, 4
syscall

jal Exit

