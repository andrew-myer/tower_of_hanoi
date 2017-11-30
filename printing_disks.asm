.data
tower1: .space 100
tower2: .space 100
tower3: .space 100
newLine: .asciiz "\n"
blank: .asciiz "|"
blank_space: .asciiz " "
ex: .asciiz "x"

.text
la $s0, tower1		# allocate array tower1 to $s0
la $s1, tower2		# allocate array tower2 to $s6
la $s2, tower3		# allocate array tower3 to $s7

li $t0, 25 		# t0 is a constant n.
li $t1, 0 		# t1 is our counter (i)
addi $t7, $t1,1

loop:
beq $t1, $t0, refresh_counter # if t1 == 10 we are done
sll $t2, $t1, 2		# multiply t1 by 4

add $t3,$t2,$s0		# $t3 = $tower1[i]
add $t4,$t2,$s1		# $t4 = $tower1[i]
add $t5,$t2,$s2		# $t5 = $tower1[i]

sw $t7, 0($t3)		# tower1[i] = i
sw $t7, 0($t4)		# tower2[i] = 0
sw $t7, 0($t5)		# tower3[i] = 0

addi $t1, $t1, 1 	# add 1 to t1
add $t7, $t7,1
j loop 			# jump back to the top

refresh_counter:
li $t1, 0 		# t1 is our counter (i)
j print_loop

print_loop:
beq $t1, $t0, end 	# if t1 == 10 we are done

sll $t2, $t1, 2		# multply t1 by 4

add $t3,$t2,$s0		# $t3 = $tower1[i]
add $t4,$t2,$s1		# $t4 = $tower1[i]
add $t5,$t2,$s2		# $t5 = $tower1[i]

lw $s5, 0($t3)		# tower1[i] = i
lw $s6, 0($t4)		# tower2[i] = 0
lw $s7, 0($t5)		# tower3[i] = 0

beq $s5, 0, tower_1_num0
j tower_1_numgreater0


#----------------------------------------------
# prints tower 1
#----------------------------------------------
#prints the "|" if the number is 0 for tower 1
tower_1_num0:
li $v0, 4 
la $a0, blank
syscall
j tower_1_blank_spaces

tower_1_numgreater0:
add $t2,$s5,$0 				# t0 is a constant 10
li $t3, 0 				# t1 is our counter (i)
xloop:
beq $t3, $t2, tower_1_blank_spaces	# if t1 == 10 we are done

li $v0, 4 
la $a0, ex
syscall

addi $t3, $t3, 1 			# add 1 to t1
j xloop 				# jump back to the top


# prints the blank space for tower 1
tower_1_blank_spaces:
beq $s5, $0,isZero1
sub $t2,$t0,$s5
j is_zero_1_done
isZero1:
subi $t2,$t0,1
is_zero_1_done:

li $t3, 0 				# t1 is our counter (i)

# loop inside of tower_1_num_0_blank_spaces
tower_1_blank_spaces_loop:
beq $t3, $t2, tower_2_decide 		# if t1 == 10 we are done

li $v0, 4 
la $a0, blank_space
syscall

addi $t3, $t3, 1 			# add 1 to t1
j tower_1_blank_spaces_loop 		# jump back to the top
#--------------------------------------------------


#----------------------------------------------
# prints tower 2
#----------------------------------------------
#prints the "|" if the number is 0 for tower 2
tower_2_decide:
beq $s6, $0, tower_2_num0
j tower_2_numgreater0

#decides whether 0 or not
tower_2_num0:
li $v0, 4 
la $a0, blank
syscall
j tower_2_blank_spaces

tower_2_numgreater0:
add $t2,$s6,$0 				# t0 is a constant 10
li $t3, 0 				# t1 is our counter (i)
xxloop:
beq $t3, $t2, tower_2_blank_spaces 	# if t1 == 10 we are done

li $v0, 4 
la $a0, ex
syscall

addi $t3, $t3, 1 			# add 1 to t1
j xxloop 				# jump back to the top


# prints the blank space for tower 1
tower_2_blank_spaces:
beq $s6, $0,isZero2
sub $t2,$t0,$s6
j is_zero_2_done
isZero2:
subi $t2,$t0,1
is_zero_2_done:

li $t3, 0 				# t1 is our counter (i)

# loop inside of tower_1_num_0_blank_spaces
tower_2_blank_spaces_loop:
beq $t3, $t2, tower_3_decide 		# if t1 == 10 we are done

li $v0, 4 
la $a0, blank_space
syscall

addi $t3, $t3, 1 # add 1 to t1
j tower_2_blank_spaces_loop 		# jump back to the top
#--------------------------------------------------


#---------------------------------------------------
# prints tower 3
#----------------------------------------------
#prints the "|" if the number is 0 for tower 2
tower_3_decide:
beq $s7, 0, tower_3_num0
j tower_3_numgreater0

#decides whether 0 or not
tower_3_num0:
li $v0, 4 
la $a0, blank
syscall
j tower_3_blank_spaces

tower_3_numgreater0:
add $t2,$s7,$0 				# t0 is a constant 10
li $t3, 0 				# t1 is our counter (i)
xxxloop:
beq $t3, $t2, tower_3_blank_spaces	# if t1 == 10 we are done

li $v0, 4 
la $a0, ex
syscall

addi $t3, $t3, 1 			# add 1 to t1
j xxxloop 				# jump back to the top


# prints the blank space for tower 1
tower_3_blank_spaces:
beq $s7, $0,isZero3
sub $t2,$t0,$s7
j is_zero_3_done
isZero3:
subi $t2,$t0,1
is_zero_3_done:

li $t3, 0 				# t1 is our counter (i)

# loop inside of tower_1_num_0_blank_spaces
tower_3_blank_spaces_loop:
beq $t3, $t2, endOfLine			# if t1 == 10 we are done

li $v0, 4 
la $a0, blank_space
syscall

addi $t3, $t3, 1 			# add 1 to t1
j tower_3_blank_spaces_loop 		# jump back to the top
#--------------------------------------------------


#---------------------------------------------------
# ends the line and starts on the next one
#---------------------------------------------------
endOfLine:
li $v0, 4 
la $a0, newLine
syscall
j increment
#-----------------------------------------------------


#-----------------------------------------------------
# increments the counter in the print loop
#-----------------------------------------------------
increment:
addi $t1, $t1, 1 # add 1 to t1
j print_loop # jump back to the top
#-----------------------------------------------------


#-----------------------------------------------------
# end of loop
#-----------------------------------------------------
end: