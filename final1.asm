.text
main:
   la $t2,exp   #Load the address of the array into $t2
#Polling on the receiver control and read the byte from the receiver data
   lui $t0, 0xffff #ffff0000
   li $s0,0
   li $s1,4
inputloop1:
   bge $s0,$s1,computeresult   #If $s0=4, exit the loop
readChar:  
   lw $t1, 0($t0)    #control
   andi $t1,$t1,0x0001
         beq $t1,$zero, readChar
         lw $v0, 4($t0)    #data
         sb $v0,0($t2)   #Save the character into array
         addi $t2,$t2,1   #Goto next index of the array
         addi,$s0,$s0,1   #Increment $s0 by1
         j inputloop1
           
computeresult:  
#Computer the result Z  
  
   la $t2,exp   #Load the address of the array into $t2
   lb $a0,($t2)   #Pass the first digit to char2num
   jal char2num   #Call char2num
   move $t4,$v0   #Save the returned number into $t4

   addi $t2,$t2,2  
  
   lb $a0,($t2)   #Pass the 2nd digit to char2num
   jal char2num   #Call char2num
   move $t5,$v0   #Save the returned number into $t4      

   add $t4,$t4,$t5   #Add two digits
  
   li $t5,9
   bgt $t4,$t5,twodigits   #If the result have two digits, gotot label twodigits  
   j singledigit        #If result have only one digit , goto label singledigit
#Write the result into array
twodigits:
   li $a0,1
   jal num2char
   move $t5,$v0
   addi $t2,$t2,2
   sb $t5,($t2)
   subi $t4,$t4,10
   subi $t2,$t2,1
singledigit:
   move $a0,$t4
   jal num2char
   addi $t2,$t2,2
   sb $v0,($t2)
  
#Polling on the transmitter control and write into the transmitter data
#to display the experssion on the display
   lui $t0, 0xffff #ffff0000
   la $t2,exp
   lb $t3,($t2)
outputloop:    beqz $t3,exit
         sb $t3,12($t0)
printExpChar:
   lw $t1, 8($t0) #control
   andi $t1,$t1,0x0001
   beq $t1,$zero, printExpChar
   addi $t2,$t2,1
   lb $t3,($t2)      
   j outputloop
  
exit:   li $v0,10    #Exit the program
   syscall
#Converts ascii character to number
char2num: lb $t0, asciiZero
   subu $v0, $a0, $t0
   jr $ra
#Converts the number to ascii character
num2char: lb $t0, asciiZero
   addu $v0, $a0, $t0
   jr $ra
.data
asciiZero: .byte '0'
exp: .space 30  