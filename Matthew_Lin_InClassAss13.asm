# Matthew Lin
# B01211593
.data
hourlyRate:	.float 10.5
expenses:	.float 0.0
numberHours:	.float 5
constantExpense:	.float 315.30
hours:		.word 0
message1:	.asciiz "Please enter the number of hours: " 
message2: 	.asciiz "The total expenses are: "
.text
# load the variables from memory into floating point registers
lwc1 $f0,hourlyRate
lwc1 $f1,constantExpense

la $a0, message1	# Prompt for hours
li $v0, 4
syscall

li $v0, 5		# Put hours in $v0
syscall

move $a0, $v0		# Move hours to $a0

jal calcExp		# Jump to procedure

la $a0, message2 	# Print results
li $v0, 4
syscall

li $v0, 2 # Call print
mov.s  $f12, $f0 # Place value to be printed into $f12
syscall

li $v0, 10		# Exit program
syscall

calcExp: 
mtc1 $a0, $f4		# Move integer into float register
cvt.s.w $f2, $f4	# Convert integer to float
mul.s $f3, $f0, $f2 # Hourly rate * number of hours
add.s $f0, $f3, $f1 # adds constant expense
swc1 $f0, expenses

jr $ra		




	