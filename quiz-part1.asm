        .text
        .globl main
main:


.data
inputText: .asciiz "Fahrenheit: "
outputText: .asciiz "Celsius: "
delta: .float 32.0
scalar: .float 5.0
another_scalar: .float 9.0

.text
li $v0, 4
la $a0, inputText
syscall

li $v0, 6
syscall

l.s $f1, delta
l.s $f2, scalar
l.s $f3, another_scalar

sub.s $f0, $f0, $f1
mul.s $f0, $f0, $f2
div.s $f0, $f0, $f3

li $v0, 4
la $a0, outputText
syscall

li $v0, 2
mov.s $f12, $f0
syscall

li $v0, 10
syscall