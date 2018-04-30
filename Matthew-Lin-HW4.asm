# Matthew Lin B01211593
# Homework 4
.data
A: .word 110, 160, 20, 70, 60, 140,150, 80, 90,100, 10, 30, 40,120,130,50
size: .word 16 # length of array A
shiftAmount: .word 4 # use to divide and multiply by 16
min: .word 0
max: .word 0
sum: .word 0
average: .word 0
largestInt: .word 2147483647 # use this for min procedure
message1: .asciiz "\nThe minimum is: "		
message2: .asciiz "\nThe maximum is: "
message3: .asciiz "\nThe sum is: "
message4: .asciiz "\nThe average is: "

.text
la $s0, A	# Store address of A in $s0
lw $t4, size	# Store size of Array in $t4
lw $t6, A	# Store first element in $t6
	


jal Minimum	# Jump to Minumum Function
li $v0, 4
la $a0, message1	# Print Message 1
syscall
move $a0, $t6		# Print Minumum
li $v0, 1
syscall
li $t0, 0		# Reset Couunter
lw $t3, A		# Reset first element

jal Maximum
li $v0, 4
la $a0, message2	# Print Message 2
syscall
move $a0, $t3		# Print Maximum
li $v0, 1
syscall
li $t0, 0


jal Sum
li $v0, 4
la $a0, message3	# Print Message 3
syscall
move $a0, $t5		# Print Sum
li $v0, 1
syscall
li $t0, 0

jal Average
li $v0, 4
la $a0, message4	# Print Message 4
syscall
move $a0, $t5		# Print Average
li $v0, 1
syscall

j Exit			# Jump to Exit

Minimum:

	li $t2, 0		# Reset shift counter
	sll $t2, $t0, 2		# Store counter times 4 into $t2
	add $t1,$t2,$s0		# Put element i address in $t1
	addi $t0, $t0, 1	# Increment loop counter
	lw $s1, ($t1)		# Put contenst in $t1's address in $s1
	beq $t0, $t4, Escape	# Check if at end of array
	ble $t6, $s1, Minimum	# Check if it is less that set minimum
	move $t6, $s1		# Move to $t6 if it is smaller element

	j Minimum

Maximum:
	li $t2, 0
	sll $t2, $t0, 2
	add $t1,$t2,$s0	
	addi $t0, $t0, 1
	lw $s1, ($t1)
	beq $t0, $t4, Escape
	bge $t3, $s1, Maximum	# Check if it is greater than set maximum
	move $t3, $s1		# Move to $t3 if it is greater element
	j Maximum

Sum:
	li $t2, 0
	sll $t2, $t0, 2
	add $t1,$t2,$s0	
	lw $s1, ($t1)
	add $t5, $t5, $s1	# Sum up the values
	addi $t0, $t0, 1
	beq $t0, $t4, Escape
	j Sum

Average:
	srl $t5, $t5, 4		# Average of values (divide sum by 16)
	j Escape


Escape:
	jr $ra			# Used to exit function

Exit:
li	$v0, 10		# Close Program
	syscall

