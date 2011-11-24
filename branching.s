#-----------------------------------------------
# Program:  Comparison, branching, looping
#
# Author: Brendan Shaklovitz
#
# Description: User enters integer 1, which is stored in memory.
#              User then enters integer 2.  If int2 = int1, the program 
#              says the users is successful and exits.  Otherwise, the 
#              program alerts the user to whether int2 is < or > and asks 
#              the user to re-enter int2, until int2 = int1.
#
# Arguments/Parameters: int1  = 32 bit binary value
#                       int2  = 32 bit binary value
#
# Output/Returns:       Display result of comparison of int1 and int2
#
# References: Patterson and Hennessy, MIPS
#
# Conclusion: How many tries required to guarantee a solution? 7 tries (floor of log base 2 of 127 + 1)
#  
#-----------------------------------------------
          .data
p1prompt: .asciiz  "\nPlayer 1: Enter an integer: " 
p2prompt: .asciiz  "\nPlayer 2: Enter an integer: "
correct:  .asciiz  "\n correct" 
lowReply: .asciiz  "\ntoo low\n"
highReply:.asciiz  "\ntoo high\n"
int1:   .word    0                        
int2:   .word    0  
guessPrompt: .asciiz "\n# of valid guesses: "                       
guessCount: .word 0
lowBound: .word 0
highBound: .word 128
lowPrompt: .asciiz "\nInput too low; try again"
highPrompt: .asciiz "\nInput too high; try again"

          .text
          .globl   main
main:
          li       $v0, 4          
          la       $a0, p1prompt     # player 1 prompt
          syscall                   

          li       $v0, 5           # read P1's input
          syscall                
          la       $t0, int1     
          sw       $v0, 0($t0) 
          lw       $t0, ($t0)        
          lw       $t1, lowBound
          ble      $t0, $t1, TOOLOW
          lw       $t1, highBound
          bge      $t0, $t1, TOOHIGH
          j        PROMPT
TOOLOW:
          la       $a0, lowPrompt
          li       $v0, 4
          syscall
          j        main
TOOHIGH:
          la       $a0, highPrompt
          li       $v0, 4
          syscall
          j        main
PROMPT:
          li       $v0, 4          
          la       $a0, p2prompt     # player 2 prompt
          syscall                   
          
          li       $v0, 5           # read P2's input
          syscall                   
          sw       $v0, int2 
          lw       $t3, guessCount 
          addi     $t3, $t3, 1
          sw       $t3, guessCount

          la       $t0, int1
          lw       $t1, 0($t0) #int1 stored in $t1
          lw       $t2, int2   #int2 stored in $t2
          bne      $t1, $t2, GREATER   # branch if int1 != int2 
EQUAL:                              
          li       $v0, 4           
          la       $a0, correct     # int1=int2
          syscall
          li       $v0, 4
          la       $a0, guessPrompt
          syscall    
          li       $v0, 1
          lw       $a0, guessCount    
          syscall        
          j        DONE   
GREATER:                               
          slt      $t3, $t1, $t2    # if int1 < int2, t3 = 1, else t3 = 0
          beq      $t3, $zero, LESS # if int1 > int2, go to less
          li       $v0, 4           
          la       $a0, highReply    
          syscall                   
          j        PROMPT   
LESS:                           
          li       $v0, 4          
          la       $a0, lowReply  
          syscall                   
          j        PROMPT
DONE:                               
          li       $v0, 10         
          syscall
          .end     main

