# Matthew Lin
# B01211593
.data 
message1:	.asciiz "Enter a number between 1-10: "
message2:	.asciiz "Goodbye!"

.text
li $v0, 4		#Prompt for number
la $a0, message1
syscall

li $v0, 5		#Save number
syscall

move $a0, $v0

tgei $a0, 4		#Condition "branch"

li $v0, 4
la $a0, message2
syscall

li $v0, 10
syscall

.ktext 0x80000180
move $k0, $v0 #Save v0 value
move $k1, $a0 #Save s0, value
la $a0, message3 #Message to print
li $v0, 4
syscall

move $v0, $k0
move $a0, $k1

mfc0, $k0, $14 # coprocessor 14 (EPC) has reister of the trapping instruction
addi $k0, $k0, 4 # add 4 to point to next instruction
mtc0 $k0, $14 # store new address back into $14
eret		# Error return; set PC back to user program

.kdata 
message3:	.asciiz "Trap generated!!\n"

