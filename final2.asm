.data
input: .asciiz "Enter a string(either max 20 charatcers or q termination character):\n"
buffer: .space 20
output: .asciiz "\nEntered string is: "
#Main program
.text
.globl main
main:
#Prompt for string enter
la $a0,input
li $v0,4
syscall
#Read character by character
li $t0,0                              #counter
la $s0,buffer                         #address of the buffer
#Loop until 20 character read
loop:
beq $t0,20,print
#Read character system call
li $v0,12
syscall
#Check entered character is q then exit from loop 0 in ascii 113
beq $v0,113,print
#If entered character is LF then not store
beq $v0,10,next
#Otherwise store data into buffer
sb $v0,0($s0)
#Increment address for next store
addi $s0,$s0,1
#Increment counter
addi $t0,$t0,1
#Repeat
j loop
#Get next address in case of LF
next:
addi $s0,$s0,1
addi $t0,$t0,1
j loop
#Print string
print:
#Get address of string
la $s0,buffer
#Output prompt
la $a0,output
li $v0,4
syscall
#Loop to print by char
loopPrint:
beq $t0,0,exit
lb $a0,0($s0)
li $v0,11
syscall
addi $s0,$s0,1
addi $t0,$t0,-1
j loopPrint
#End of the program
exit:
li $v0,10
syscall

