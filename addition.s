#---------------------------------------------------
# Program: Addition  
#
# Author:  Brendan Shaklovitz    
#
# Description:
#   1) reads the 5 words labeled "Data" from memory and sums them; does the same for the 5 bytes labeled "Value"
#
# Output/Returns:
#        Displays sums of words and byte values
#
# Reference: Patterson and Hennessey, SPIM.
# Misc: None

#Write an MIPS assembly program which contains the following data statements.

#          .data
#Data:   .word 8, 127, 983, 16000, 65537
#Value: .byte 255, 128, 64, 32, 5

#Your program should read the 5 words labeled “ Data” from memory and sum them. 
#Likewise, read the five bytes labeled “Value” from memory and display their sum also. 
#Comment on the sum of the five byte values. (HINT: did you use signed or unsigned load?) 
#What happens if the byte sum is stored in memory then retrieved and displayed? 

#There are at least 3 different answers for the sum of bytes and each may be correct. 
#Discuss the conditions under which each result is correct and document your results in your program's comments section 
#
# Conclusions: Assembly language is more difficult than expected
#              Unsigned sum of bytes (without storing the byte sum in memory and retrieving it) is just the sum of the values.
#              If you use signed byte sums, 255 and 128 both become negative values, so the sum is different. 
 
#---------------------------------------------------
         .data
Data:     .word       8, 127, 983,  16000, 65537 
Test:	  .word	      0
Value:    .byte       255, 128, 64, 32, 5
WordSum:  .asciiz     "Sum of words 8, 127, 983, 16000, and 65537: "
UnsignedByteSum: .asciiz "\nUnsigned sum of bytes 255, 128, 64, 32, 5: "
SignedByteSum: .asciiz "\nSigned sum of bytes 255, 128, 64, 32, 5: "


        .text
        .globl   main
main:

	lw	$t1,Data
	lw	$t2,Data+4
	lw	$t3,Data+8
	lw	$t4,Data+12
	lw	$t5,Data+16
	add	$t0, $t1, $t2
	add	$t6, $t3, $t4
	add	$t7, $t0, $t6
	add 	$t0, $t7, $t5
	la	$a0, WordSum
	li	$v0, 4
	syscall
	la	$a0, ($t0)
	li      $v0, 1
	syscall
	la	$a0, UnsignedByteSum
	li	$v0, 4
	syscall
	
	la	$t0,Value
	lbu	$t1,0($t0)
	la	$t0,1($t0)
	lbu	$t2,0($t0)
	la	$t0,1($t0)
	lbu	$t3,0($t0)
	la	$t0,1($t0)
	lbu	$t4,0($t0)
	la	$t0,1($t0)
	lbu	$t5,0($t0)
	la	$a0, ($t5)
	
	
	add	$t0, $t1, $t2
	add	$t6, $t3, $t4
	add	$t7, $t0, $t6
	add 	$t0, $t7, $t5
	la	$a0, ($t0)
	li	$v0, 1
	syscall
	
	
	
	
	
        li       $v0, 10        # return to kernel from main routine
        syscall

        .end      main




