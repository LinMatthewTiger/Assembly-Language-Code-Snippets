# Matthew Lin
# B01211593
 
.data
Message1:	.asciiz "\nEnter First Name: "	# Make messages and store them in variables
Message4:	.asciiz "Goodbye!"
fout:		.asciiz "output.txt"
comma: 		.asciiz ","
myString: 	.space 100
CopiedString: 	.space 40
MaxChar:	.word 100
Length:		.word 0
nullTerm:	.byte '0'
newLine: 	.byte '\n'
.text
lb	$t5, nullTerm	#Declarations
lb	$t4, newLine
la	$a1, CopiedString

li	$v0,4		# load intermediate 4 for asciiz
la	$a0, Message1	# load address
syscall

la	$a0, myString
li 	$v0, 8		# Assigns input to myString
syscall


jal strlen

jal trimNewline

jal strlen

jal strcpy

# Open file
 li $v0, 13 # system call for open file
 la $a0, fout # output file name
 li $a1, 1 # Open for writing (flags are 0: read, 1: write)
 li $a2, 0 # mode is ignored
 syscall # open a file (file descriptor returned in $v0)
 move $s6, $v0 # save the file descriptor
 
 # Writing name
 li $v0, 15 # system call for write to file
 move $a0, $s6 # file descriptor
 la $a1, CopiedString # address of buffer from which to write
 move $a2, $t2 # hardcoded buffer length
 syscall # write to file
 
 # Writing comma
 li $v0, 15 # system call for write to file
 move $a0, $s6 # file descriptor
 la $a1, comma # address of buffer from which to write
 li $a2, 1 # hardcoded buffer length
 syscall # write to file
 
 #Close File
 li $v0, 16 # system call for close file
 move $a0, $s6 # file descriptor to close
 syscall # close file

li	$v0,4		# Goodbye!
la	$a0, Message4	
syscall 
 
jal Exit

strlen:			#Counts items in the array

	add $t0,$t2,$a0		
	lb $t1, 0($t0)
	beq $t1,$t4, Escape	
	addi $t2, $t2, 1	#Increments counter
	j strlen
	
trimNewline:			#Trims the /n to a 0
	addi $t0,$t2,-1		#Decrements the index of array
	add $t1, $t0, $a0	#Stores location in array in $t1
	lb $t3, 0($t1)		#Puts byte in $t3
	bne $t3, $t4, Escape	#Escapes if it it's not /n
	sb $t5, 0($t1)		#Changes /n to 0
	jr $ra
	
Escape:
	jr $ra
	
strcpy: 
	add $t0, $t6, $a0	#Obtain index of input string
	lb $t3, 0($t0)		#Stores byte in $t3
	add $t1, $t6, $a1	#Obtain index of empty copied string
	sb $t3, 0($t1)		#Put byte in index of empty copied string
	beq $t6, $t2, Escape	#Break if equal to length of string
	addi $t6, $t6, 1	#Increment $t6
	j strcpy

Exit:
	li	$v0, 10		# Close Program
	syscall
