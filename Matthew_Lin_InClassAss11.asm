# Matthew Lin
# In Class Assignment 11

.data
	PI: .float 3.14
	msg: .asciiz  "Happy PI day! Enjoy "
	byte: .byte '\n'
.text 
main:
	la $a0, msg
	li $v0, 4
	syscall
	
	li $v0, 2
	lwc1 $f12, PI
	syscall
	
	la $a0, byte
	li $v0, 4
	syscall
	
exit:
	li $v0, 10
	syscall
	
	