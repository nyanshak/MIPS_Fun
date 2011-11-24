#-----------------------------------------------
# Program:  Make-change
#
# Author: Brendan Shaklovitz
#
# Description: Accepts any number from 1 to 99 cents.
#              Determines the least number of coins (half-dollar, 
#              quarter, dime, nickel, and pennies) which can be 
#              used to make up that total value and prints 
#              out the results in a tabular format.

#              Then repeats the calculation for each case listed: 
#                 you do not have 2) any half-dollars, 3) any quarters, 
#                 4) any dimes, or 5) any nickels. (but lots’a pennies)
#
# Arguments/Parameters: Integer between 1 and 99 (cents)
#
# Output/Returns: Smallest number of coins that make up integer input value       
#  
#-----------------------------------------------
          .data
numHalfDollars: .asciiz  "\n\tHalf Dollars\t: "
numQuarters: .asciiz  "\n\tQuarters\t: "
numDimes:    .asciiz "\n\tDimes\t\t: "
numNickels:  .asciiz "\n\tNickels\t\t: "
numPennies:  .asciiz "\n\tPennies\t\t: "
prompt:      .asciiz "\nEnter number of cents (between 1 and 99): "
int1:   .word    0   
guessPrompt: .asciiz "\n# of valid guesses: "                       
guessCount: .word 0
lowBound: .word 0
highBound: .word 99
lowPrompt: .asciiz "\nInput too low; try again"
highPrompt: .asciiz "\nInput too high; try again"
allCoins: .asciiz "\nALL COINS"
noHalfDollars: .asciiz "\nNO HALF-DOLLARS"
noQuarters: .asciiz "\nNO QUARTERS"
noDimes: .asciiz "\nNO DIMES"
noNickels: .asciiz "\nNO NICKELS"
counter:    .word 0

          .text
          .globl   main
main:
          li       $v0, 4          
          la       $a0, prompt     # prompt for number of cents
          syscall                   

          li       $v0, 5           # read input
          syscall                
          la       $t0, int1     
          sw       $v0, 0($t0)
          lw       $t0, ($t0)        
          lw       $t1, lowBound
          ble      $t0, 1, TOOLOW
          lw       $t1, highBound
          bgt      $t0, 99, TOOHIGH
          lw       $s0, counter
          lw       $s1, int1
          
LOOP1:    
          move     $s2, $s1
          addi     $s0, $s0, 1
          bgt      $s0, 1, LOOP2
          la       $a0, allCoins
          li       $v0, 4
          syscall
          j        HALFDOLLARS
LOOP2:
          bgt      $s0, 2, LOOP3
          la       $a0, noHalfDollars
          li       $v0, 4
          syscall
          j        QUARTERS
LOOP3:
          bgt      $s0, 3, LOOP4
          la       $a0, noQuarters
          li       $v0, 4
          syscall
          j        HALFDOLLARS
LOOP4:
          bgt      $s0, 4, LOOP5
          la       $a0, noDimes
          li       $v0, 4
          syscall
          j        HALFDOLLARS
LOOP5:
          bgt      $s0, 5, DONE
          la       $a0, noNickels
          li       $v0, 4
          syscall
          j        HALFDOLLARS
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
HALFDOLLARS:
          li       $v0, 4          
          la       $a0, numHalfDollars
          syscall
          li       $t1, 50       	              		
          div      $s2, $t1              
          mflo     $t3		     # quotient
          mfhi     $s2		     # remainter
          li       $v0, 1
          move     $a0, $t3	     # quotient (# coins) put into $a0
          syscall   
          beq      $s0, 3, DIMES
QUARTERS: 
          li       $v0, 4          
          la       $a0, numQuarters
          syscall
          li       $t1, 25      	              		
          div      $s2, $t1              
          mflo     $t3		     # quotient
          mfhi     $s2		     # remainter
          li       $v0, 1
          move     $a0, $t3	     # quotient (# coins) put into $a0
          syscall 
          beq      $s0, 4, NICKELS
DIMES:
          li       $v0, 4          
          la       $a0, numDimes
          syscall
          li       $t1, 10       	              		
          div      $s2, $t1              
          mflo     $t3		     # quotient
          mfhi     $s2		     # remainter
          li       $v0, 1
          move     $a0, $t3	     # quotient (# coins) put into $a0
          syscall
          beq      $s0, 5, PENNIES
NICKELS:
          li       $v0, 4          
          la       $a0, numNickels
          syscall
          li       $t1, 5       	              		
          div      $s2, $t1              
          mflo     $t3		     # quotient
          mfhi     $s2		     # remainter
          li       $v0, 1
          move     $a0, $t3	     # quotient (# coins) put into $a0
          syscall 
PENNIES:
          li       $v0, 4          
          la       $a0, numPennies
          syscall
          move     $a0, $s2          # pennies	              		
          li       $v0, 1
          syscall 
          j        LOOP1
DONE:                               
          li       $v0, 10         
          syscall
          .end     main

