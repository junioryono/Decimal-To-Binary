.data
	# HEADER
	intro1: .asciiz "=======================================================================\n"
	intro2: .asciiz "Program Description:\tDecimal to Binary\n"
	intro3: .asciiz "Author:\t\t\tAmer Yono\n"
	intro4: .asciiz "Creation Date:\t\t10/05/2021\n"
	newLine: .asciiz "\n"
	
	# LAB
	str1: .asciiz "Input a number in decimal form:  "
    	str2: .asciiz "The number "
    	str3: .asciiz " in binary is: "
   	 str4: .asciiz "Cannot be a negative input.\n"
    	
.text
	# HEADER
	li $v0, 4
	la $a0, intro1
	syscall
	
	li $v0, 4
	la $a0, intro2
	syscall
	
	li $v0, 4
	la $a0, intro3
	syscall
	
	li $v0, 4
	la $a0, intro4
	syscall
	
	li $v0, 4
	la $a0, intro1
	syscall

	# LAB
getDecimal:
	li $v0, 4
	la $a0, str1
	syscall

	li $v0, 5
	syscall
	
	addi $t0, $v0, 0
	blt $t0, 0, case1 # Handle negative input

	li $v0, 4
	la $a0, intro1
	syscall

	li $v0, 4
	la $a0, str2
	syscall

	li $v0, 1
	addi $a0, $t0, 0
	syscall

	li $v0, 4
	la $a0, str3
	syscall

	li $t5, 2
	jal func

	li $v0, 4
	la $a0, newLine
	syscall

	li $v0, 4
	la $a0, intro1
	syscall
	
	li $v0, 10
	syscall

func:
	li $t2, 0 # Counter
	
	# Get binary numbers and store in stack
	loop1:
		addi $sp, $sp, -4

		div $t0, $t5
		mfhi $t1
		mflo $t0

		addi $t2, $t2, 1
		sw $t1, 0($sp)
		
		bne $t0, $zero, loop1
		li $t4, 32
		li $t3, 0
		sub $t4, $t4, $t2
		
	# Print Zeros
	loop3:
		li $v0, 1
		addi $a0, $t3, 0
		syscall
		addi $t4, $t4, -1
		bne $t4, $zero, loop3
		
	# Print binary numbers from stack
	loop2:
		li $v0, 1
		lw $a0, 0($sp)
		syscall
		
		addi $t2, $t2, -1
		addi $sp, $sp, 4
		bne $t2, $zero, loop2
		jr $ra

# Error handle for negative decimal input
case1:
	li $v0, 4
	la $a0, str4
	syscall
	
	j getDecimal
