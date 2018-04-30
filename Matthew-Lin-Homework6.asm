# Matthew Lin
# B01211593
.data
AddOp: .byte '+'
SubOp: .byte '-'
MulOp: .byte '*'
DivOp: .byte '/'
QuitOp: .byte '&'
message1:	.asciiz "\nEnter Operator:  " 
message2: 	.asciiz "\nEnter First Float: "
message3: 	.asciiz "Enter Second Float: "
message4: 	.asciiz "Result = "
message5: 	.asciiz "\nError, you have entered an invalid operator"
message6:	.asciiz "\nGoodbye!"
.text
Repeat:		# Marker to repeat the program
lb $t0, AddOp	# load the variables from memory into registers
lb $t1, SubOp
lb $t2, MulOp
lb $t3, DivOp
lb $t4, QuitOp
li $t6, 0

la $a0, message1	# Prompt for operation
li $v0, 4
syscall

li $v0, 12		# Obtain byte
syscall

move $t5, $v0

beq $t4, $t5, Quit	# Quit program if byte is &

la $a0, message2	# Prompt for first float
li $v0, 4
syscall

li $v0, 6
syscall

mov.s $f12, $f0

la $a0, message3	# Prompt for second float
li $v0, 4
syscall

li $v0, 6
syscall

mov.s $f13, $f0

beq $t0, $t5, addCalc	# Compare input byte to branch to correct operation
beq $t1, $t5, subCalc
beq $t2, $t5, mulCalc
beq $t3, $t5, divCalc
beq $t6, $zero, Invalid	# Display invalid operation if operation not found



Continued:
la $a0, message4	# Display Result
li $v0, 4
syscall

mov.s $f12, $f0
li $v0, 2
syscall

j Repeat		# Repeat program

Quit:
la $a0, message6	# End program
li $v0, 4
syscall

li $v0, 10
syscall

Invalid:
la $a0, message5	# Display error message
li $v0, 4
syscall

j Repeat	# Repeat program

addCalc:
add.s $f0, $f12, $f13	# add operation
addi $t6, $t6, 1
j Continued


subCalc:
sub.s $f0, $f12, $f13	# subtraction operation
addi $t6, $t6, 1
j Continued

mulCalc:
mul.s $f0, $f12, $f13	# multiplication operation
addi $t6, $t6, 1
j Continued

divCalc:
div.s $f0, $f12, $f13	# division operation
addi $t6, $t6, 1
j Continued





