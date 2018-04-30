# Matthew Lin
# B01211593
.data 
	celsius: .float 0.0
	boil: 	.float 100
	freeze:	.float 0
	constant1: .float 32
	constant2: .float 5
	constant3: .float 9
	message1:	.asciiz "The temperature in Celsius is: "
	message2:	.asciiz " You could freeze water! "
	message3:	.asciiz " You could boil water! "
	message4: 	.asciiz "Please enter a temperature in fahrenheit: "
	newLine:	.asciiz "\n"
	
.text
	l.s $f13, boil
	l.s $f14, freeze
	l.s $f18, constant1
	l.s $f19, constant2
	l.s $f20, constant3
	
	# Prompt for temperature
	li $v0, 4
	la $a0, message4
	syscall
	
	li $v0, 6
	syscall
	
	mov.s $f12, $f0

	jal Convert
	
	# Print message
	li $v0, 4
	la $a0, message1
	syscall
	
	li $v0, 2
	mov.s $f12, $f0
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	# Check if temp < 0
	c.le.s $f0, $f14
	bc1t Freezing
	
	# Check if temp is 0 < x < 100
	c.le.s $f0, $f13
	bc1t Exit
	
	# Output if temp is > 100
	li $v0, 4
	la $a0, message3
	syscall
	
	j Exit
	
	
	
Exit:	# Exit function
	li $v0, 10
	syscall
	
Freezing:	# Output for temp < 0
	li $v0, 4
	la $a0, message2
	syscall
	
	j Exit
	
	
Convert:	# Convert temperature to celsius
	
	div.s $f4, $f19, $f20 # 5/9 in $f4
	sub.s $f0, $f12, $f18 # farh - 32
	mul.s $f0, $f0, $f4 # celsius is in $f0
	
	s.s $f0, celsius
	
	jr $ra
	
	
	
	
