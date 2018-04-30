# Matthew Lin
# B01211593

.data 
message1:	.asciiz "Please Enter the Edge Length of the Base of the Right Triange: "
message2:	.asciiz "Exiting the Program"
star:		.asciiz "*"
indent:		.asciiz "\n"

.text 
Repeat:
li $t0, 0		#Reset counters
li $t1, 0
li $t2, 0

li $v0, 4		#Prompt for edge
la $a0, message1
syscall

li $v0, 5		#Input number
syscall

move $t1, $v0

ble $t1, $zero, Exit	#If number is 0, exit program

jal printTriangle	

printTriangle:

li $t3, 0		#Reset secondary counter
move $t2, $t0		
ble $t1, $t0, Repeat	#Restart program
j Stars

Stars:			#Stack stars based on height of triangle
li $v0, 4
la $a0, star
syscall

ble $t2, $t3, Indent
addi $t3, $t3, 1

j Stars

Indent:			#Indent at appropriate times
li $v0, 4
la $a0, indent
syscall

addi $t0, $t0, 1


j printTriangle

Exit:			#Exit program
li $v0, 4
la $a0, message2
syscall

li $v0, 10
syscall
