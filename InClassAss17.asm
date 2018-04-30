# Matthew Lin
# B01211593
 
.data
Message1:	.asciiz "\nEnter First Name: "	# Make messages and store them in variables
Message2:	.asciiz "\nEnter Last Name: "
Message3:	.asciiz "\nEnter Age: "
Message4:	.asciiz "\nEnter Gender: "
Message5:	.asciiz "\nEnter Phone: "
Message6:	.asciiz "Goodbye!"
fout:		.asciiz "sample.txt"
comma: 		.asciiz ","
myString: 	.space 100
CopiedString: 	.space 40
MaxChar:	.word 100
Length:		.word 0
nullTerm:	.byte '0'
newLine: 	.byte '\n'
.text
# Prompt for first name
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
jal Open
jal Write

# Prompt for Last name
li	 $t2, 0
lb	$t5, nullTerm	#Declarations
lb	$t4, newLine
la	$a1, CopiedString
li	$v0,4		# load intermediate 4 for asciiz
la	$a0, Message2	# load address
syscall
la	$a0, myString
li 	$v0, 8		# Assigns input to myString
syscall
jal strlen
jal Write

# Prompt for Age
li	 $t2, 0
lb	$t5, nullTerm	#Declarations
lb	$t4, newLine
la	$a1, CopiedString
li	$v0,4		# load intermediate 4 for asciiz
la	$a0, Message3	# load address
syscall
la	$a0, myString
li 	$v0, 8		# Assigns input to myString
syscall
jal strlen
jal Write

# Prompt for Gender
li	 $t2, 0
lb	$t5, nullTerm	#Declarations
lb	$t4, newLine
la	$a1, CopiedString
li	$v0,4		# load intermediate 4 for asciiz
la	$a0, Message4	# load address
syscall
la	$a0, myString
li 	$v0, 8		# Assigns input to myString
syscall
jal strlen
jal Write

# Prompt for Phone
li	 $t2, 0
lb	$t5, nullTerm	#Declarations
lb	$t4, newLine
la	$a1, CopiedString
li	$v0,4		# load intermediate 4 for asciiz
la	$a0, Message5	# load address
syscall
la	$a0, myString
li 	$v0, 8		# Assigns input to myString
syscall
jal strlen
jal Write
jal Close

Open:
# Open file
 li $v0, 13 # system call for open file
 la $a0, fout # output file name
 li $a1, 1 # Open for writing (flags are 0: read, 1: write)
 li $a2, 0 # mode is ignored
 syscall # open a file (file descriptor returned in $v0)
 move $s6, $v0 # save the file descriptor
 jr $ra
 
Write:
 # Writing to file
 li $v0, 15 # system call for write to file
 move $a0, $s6 # file descriptor
 la $a1, myString # address of buffer from which to write
 move $a2, $t2 # hardcoded buffer length
 syscall # write to file
 
 # Writing comma
 li $v0, 15 # system call for write to file
 move $a0, $s6 # file descriptor
 la $a1, comma # address of buffer from which to write
 li $a2, 1 # hardcoded buffer length
 syscall # write to file
 
 jr $ra
 
Close:
 #Close File
 li $v0, 16 # system call for close file
 move $a0, $s6 # file descriptor to close
 syscall # close file

li	$v0,4		# Goodbye!
la	$a0, Message6	
syscall 
 
jal Exit

strlen:			#Counts items in the array

	add $t0,$t2,$a0		
	lb $t1, 0($t0)
	beq $t1,$t4, Escape	
	addi $t2, $t2, 1	#Increments counter
	j strlen
	
Escape:
	jr $ra
	
Exit:
	li	$v0, 10		# Close Program
	syscall