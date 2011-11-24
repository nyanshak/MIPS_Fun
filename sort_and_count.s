# Author:  Brendan Shaklovitz

# a program to prompt the user to enter a sentence on the SPIM console. 
#1) Sort the letters in the sentence into the ASCII collating sequence 
#(i.e. alphabetically). Print the results and the total number of characters in the sentence.
#2) Next, print out a list of the number of times each letter occurred in the sentence.
#3) Finally, print out the total number of different characters in the sentence.

#conclusion: inputs string, sorts string, prints sorted string, prints # of occurrences of 
#            characters, and prints total # of unique characters
#inputs:     String input
#outputs:    sorted string input, # of occurrences of each character, total # of unique characters
          .data
prompt1:  .asciiz   "Type in a sentence: "
length:   .word     0
buffer:   .space    80
newline:  .asciiz   "\n"
colon:    .asciiz   ": "
frequency:.asciiz   "\nFrequency of occurrence:\n"
tChar:    .asciiz   "\nTotal # of unique characters: "

          .text
         .globl     main
main:
#-----input-----
 	la      $a0, prompt1		#  prompt for input	
	li      $v0, 4			#  printstring syscall
	syscall

	la      $a0, buffer		#  $a0 = buffer address
	li      $a1, 80			#  $a1 = length of buffer
	li      $v0, 8			#  read string syscall
	syscall

bubble:
	la      $a0, buffer		#  $a0 = buffer address
	addi    $a0, $a0, -1
	li      $v0, 0			#  $v0 is swap flag (reset to 0)


loop: 
        addi    $a0, $a0, 1       
        lbu     $t0, 0($a0)
        lbu     $t1, 1($a0)
        beq     $t1, $zero, swap 
        ble     $t0, $t1, loop
        sb      $t1, 0($a0)           # swap if needed
        sb      $t0, 1($a0)           # swap if needed
        li      $v0, 1                # Set swap flag = 1
        b       loop

swap: 
        bnez    $v0, bubble

	la      $a0, buffer		#  $a0 = buffer
	li      $v0, 4			#  system call for print string
	syscall
	
	la      $a0, frequency		#  $a0 = address of string buffer
	li      $v0, 4			#  system call for print string
	syscall
	
	la      $a0, buffer
	subi    $a0, $a0, 1    
	li      $s4, 0         
FREQLOOP:
        li      $t0, 0              	#counter
        addi    $a0, $a0, 1
        lbu     $t1, 0($a0)
        beqz    $t1, DONE
        addi    $s4, $s4, 1
        li      $t0, 1                  #first char occurrence
FREQLOOP1:
	addi    $a0, $a0, 1
        lbu     $t2, 0($a0)
        beqz    $t2, PRINT1
        bne     $t1, $t2, FREQLOOP2
        addi    $t0, $t0, 1
        j       FREQLOOP1
FREQLOOP2:
        subi    $a0, $a0, 1
        
        
PRINT1:
        move    $s0, $t0		#counter now in $s0
        move    $s1, $t1                #char
        move    $s3, $a0
        
        #
        move    $a0, $s1
        li      $v0, 11
        syscall
        # print code (char) : counter newline
        la      $a0, colon
        li      $v0, 4
        syscall
        move    $a0, $s0
        li      $v0, 1
        syscall
        la      $a0, newline
        li      $v0, 4
        syscall
        
        
        move    $a0, $s3
        j       FREQLOOP
        
        
DONE:
        la      $a0, tChar
        li      $v0, 4
        syscall
        move    $a0, $s4
        li      $v0, 1
        syscall
        #total # chars: XX
	li       $v0,10
        syscall
        .end
