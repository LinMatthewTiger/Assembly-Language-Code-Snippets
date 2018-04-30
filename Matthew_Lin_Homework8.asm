# Matthew Lin
# B01211593
.data
 	message1: 		.asciiz	"Enter File Name: "
 	message2:		.asciiz "Number of conversions: "
 	message3: 		.asciiz	"Goodbye!"
	buffer:			.space	100
	bufferLength:		.word	99
	size:			.word	30
	myString: 		.space	31
	trimmedInstring: 	.space	31
	modifiedString: 	.space	31
	comma:			.byte	','
	endl:			.asciiz "\n"
	LF: 			.byte 10 		#LINE FEED ascii code 10
	CR: 			.byte 13 		#CARRIAGE RETURN ascii code 13
	 S: 			.byte 40		#SPACE ascii code 40

.text
la $a0, message1		#Prompt for file name
li $v0, 4       		
syscall
    	
la $a0, myString		#Set file name to myString
lw $a1, size
li $v0, 8			
syscall         		
	
#Special characters
lbu $s0, LF
lbu $s1, CR
lbu $s2, S

#Loop starts
trimStrLoop:  
lb $t0, 0($a0)  	# Load the first byte
#Loop conditions
beqz $t0, endTrimStrLoop  	# if $t0 == NULL then go to label exit
beq $t0, $s0, endTrimStrLoop   	# if $t0 == LINE FEED then go to label exit
beq $t0, $s1, endTrimStrLoop   	# if $t0 == CARRIAGE RETURN then go to label exit
beq $t0, $s2, else1 
sb $t0, trimmedInstring($t2)	#$t0 != SPACE
add $t2, $t2, 1 # increment counter

else1:
nop		#Ignore space
#increment counter varivales
add $a0, $a0, 1      	# increment address
add $t1, $t1, 1 	# increment file string
j trimStrLoop  

endTrimStrLoop:  
nop

jal Open
jal Read
jal convCommas

li $v0, 4		#Print contents
la $a0, modifiedString
syscall

li $v0, 4		#Print Conversions
la $a0, message2
syscall
 	
li $v0, 1
move $a0, $t2
syscall
 	
li $v0, 4		#Print new line
la $a0, endl
syscall
	
li $v0, 4		#Print goodbye
la $a0, message3
syscall

j Exit

convCommas:
# Reset counters
addi, $t1, $zero, 0
addi, $t2, $zero, 0
lbu $s2, comma
strCopyReplace:  
lb $t0, 0($a1)  	# Load the first byte
		
#Loop conditions
beqz $t0, endStrCopyReplace  	# if $t0 == NULL then go to label exit
beq $t0, $s0, endStrCopyReplace   	# if $t0 == LINE FEED then go to label exit
beq $t0, $s1, endStrCopyReplace   	# if $t0 == CARRIAGE RETURN then go to label exit
beq $t0, $s2, else2 
sb $t0, modifiedString($t1)		#Not a comma
j skip

else2:
sb $s0, modifiedString($t1)
add $t2, $t2, 1

skip:
nop	
		
#increment counter varivales
add $a1, $a1, 1      	# increment address
add $t1, $t1, 1 	# increment file string
j strCopyReplace      

endStrCopyReplace: 
jr $ra

Open:
#open a file for writing
li   $v0, 13       		# system call for open file (code 13)
la   $a0, trimmedInstring      	# board file name
li   $a1, 0        		# Open for reading
li   $a2, 0
syscall            		# open a file (file descriptor returned in $v0)
move $s6, $v0      		# save the file descriptor 
jr $ra

Read:
#read from file
li   $v0, 14       		# system call for read from file (code 14)
move $a0, $s6      		# file descriptor 
la   $a1, buffer   		# address of buffer to which to read
lw   $a2, bufferLength     	# hardcoded buffer length
syscall            		# read from file

jr $ra
	
Exit:	
li $v0, 10		#Exit 
syscall