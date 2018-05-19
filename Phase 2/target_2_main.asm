.data
	dot:.word 0, 0
		.word 2, 6 
		.word 8, 4
		.word 7, 2
		.word 1, 6
		.word 4, 9
		.word 3, 2

	arr:.double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
		.double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
		.double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
		.double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
		.double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
		.double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
		.double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

	r:		.word 0, 0, 0, 0, 0
	save_root:	.word 0, 0, 0, 0, 0, 0, 0
	double_max: .double 999999.0

.text
sqrt:
li.d $f2, 1.0  #f2=x=1, x=float
add $s1, $zero, $zero   #s1=i=0

loop_sqrt:
div.d $f4, $a0, $f2     #f4=input/x          
add.d $f4, $f4, $a0     #f4= x+input/x
srl $f2, $f4, 0x1       #x=f4/2
addi $s1, $s1, 0x1      #i++
bne $s1, 10, loop_sqrt  #if i!=10, loop

add $f0, $zero, $s1     #f0=x
jr $ra                  #return


#---------------------------------------
# $a0 = arr[7][7]
# $a1 = dot[7][2]


# $s0 = i
# $s1 = j
# $s2 = i or j
# $s3 = dot


# $t0 = 7
# $t1 = dot[i][0]
# $t2 = dot[i][1]

# $t3 = dot[j][0]
# $t4 = dot[j][1]

# $f0 = sqrt (double)
#----------------------------------------------------




getPathLengthData:
	addi	$sp, $sp, -12
	sw	$ra, 0($sp)			# return address 
	sw	$a0, 4($sp)			# $a0 
	sw	$a1, 8($sp)			# $a1

	li	$s0, 0				# i
	li	$t0, 7				# 


Loop1:
	li	$s1, 0				#
	
Loop2:

	#-----i-----------

	la	$s3, 0($a1)			# $s3 = $a1

	sla	$s2, $s0, 3			# $s2 = i * 8
	add	$s3, $s3, $s2			# $s3 = $s3 + (i * 8)

	lw	$t1, 0($s3)			# $t1 = dot[i][0]
	lw	$t2, 4($s3)			# $t2 = dot[i][1]


	#-----j-----------

	la	$s3, 0($a1)			# $s3 = $a1

	sla	$s2, $s1, 3			# $s2 = j * 8
	add	$s3, $s3, $s2			# $s3 = $s3 + (j * 8)

	lw	$t3, 0($s3)			# $t3 = dot[j][0]
	lw	$t4, 4($s3)			# $t4 = dot[j][1]

	#-----x, y----

	sub	$t3, $t3, $t1			# x_length = dot[j][0] - dot[i][0] (x2 - x1)
	sub	$t4, $t4, $t2			# y_length = dot[j][1] - dot[i][1] (y2 - y1)

	mul	$t1, $t3, $t3			# $t1 = x_length * x_length
	mul	$t2, $t4, $t4			# $t2 = y_length * y_length

	add	$t1, $t1, $t2			# $t1 = $t1 + $t2   ($t1 = temp)

	#-----sqrt call----

	addi	$sp, $sp, -4
	sw	$a0, 0($sp)			#

	add	$a0, $zero, $t1			# $t1(temp)
	jal	sqrt				# call sqrt(temp)

	lw	$a0, 0($sp)			# $a0
	addi	$sp, $sp, 4		

	#-----arr[i][j] = sqrt----
	
	li	$t1, 56				# $t1 = 8 * 7
	mul	$t2, $s0, $t1			# $t2 = i * 8 * 7
	
	sla	$t1, $s1, 3			# $t1 = j * 8

	la	$s3, 0($a0)			# $s3 = $a0

	add	$s3, $t2, $t1			# $s3 = arr + (i * 8 * 7) + (j * 8)
	
	sw.d	$f0, 0($s3)			# arr[i][j] = sqrt

	#-----for-------------


	addi	$s1, $s1, 1			# j++
	beq	$s1, $t0, Loop1			# 
	j	Loop2

Loop_End:
	addi	$s0, $s0, 1			# i++
	bne	$s0, $t0, Loop1			# 

	lw	$ra, 0($sp)			# return address
	lw	$a0, 4($sp)			# $a0
	lw	$a1, 8($sp)			# $a1 
	addi	$sp, $sp, 12

	jr	$ra				#

main:
la $a0, arr
la $a1, dot
j getPathLengthData


#s1=d1
#s2=d2
#s3=d3
#s4=d4
#s5=d5
li $s0, 0         	  # s0<=dist  (value of 0)
l.d $f0, double_max

# for loop1
li $s1, 0
loop1:
addi $s1, $s1, 1
bge $s1, 6, exit_loop
sll $t0, $s1, 3
l.d $f2, arr($t0)           # dist = arr[0][d1]
mov.d $f4, $f2	     # dist1 = dist
c.le.d $f0, $f2
bc1t loop1		     # if (dist > dist_min) continue

# for loop2
li $s2, 0
loop2:
addi $s2, $s2, 1
bge $s1, 6, loop1
beq $s1, $s2, loop2     # continue
sll $t0, $s1, 3
sub $t0, $t0, $s1	#calculate row
add $t0, $t0, $s2
sll $t0, $t0, 3
l.d $f2, arr($t0)	#dist = arr[d1][d2]
add.d $f2, $f2, $f4	#dist = dist + dist1
mov.d $f6, $f2	#dist2 = dist
c.le.d $f0, $f2
bc1t loop2	#if (dist > dist_min) contiunue;

# for loop3
addi $s3, $s3, 1
bge $s3, 7, loop2
beq $s3, $s1, loop3
beq $s3, $s2, loop3
sll $t0, $s2, 3
sub $t0, $t0, $s2
add $t0, $t0, $s3
sll $t0, $t0, 3
l.d $f2, arr($t0)                 # dist = arr[d2][d3]
add.d $f2, $f2, $f6           # dist = dist + dist2
mov.d $f8, $f2                # dist3 = dist
c.le.d $f0, $f2 
bc1t loop3                    # if (dist > dist_min)    continue;

# for loop4
li $s4, 0
loop4:
addi $s4, $s4, 1
bge $s4, 7, loop3
beq $s4, $s1, loop4
beq $s4, $s2, loop4
beq $s4, $s3, loop4
sll $t0, $s3, 3
sub $t0, $t0, $s3
add $t0, $t0, $s4
sll $t0, $t0, 3
l.d $f2, arr($t0)                 # dist = arr[d3][d4]
add.d $f2, $f2, $f8           # dist = dist + dist3
mov.d $f10, $f2               # dist4 = dist
c.le.d $f0, $f2 
bc1t loop4                    # if (dist > dist_min)    continue;

# for loop5
li $s5, 0
loop5:
addi $s5, $s5, 1
beq $s5, $s1, loop5
beq $s5, $s2, loop5
beq $s5, $s3, loop5
beq $s5, $s4, loop5
bge $s5, 7, loop4
sll $t0, $s4, 3
sub $t0, $t0, $s4
add $t0, $t0, $s5
sll $t0, $t0, 3
l.d $f2, arr($t0)                 # dist = arr[d4][d5]
add.d $f2, $f2, $f10          # dist = dist + dist4
mov.d $f12, $f2               # dist5 = dist
c.le.d $f0, $f2
bc1t loop5                    # if (dist > dist_min)    continue;
sw $s1, r
sw $s2, r+4
sw $s3, r+8
sw $s4, r+12
sw $s5, r+16
mov.d $f0, $f2
j loop6

exit_loop:
la $v0, 1
la $a0, 1
syscall
lw $a0, course
addi $a0, 1
syscall
lw $a0, r+4
addi $a0, 1
syscall
lw $a0, r+8
addi $a0, 1
syscall
lw $a0, r+12
addi $a0, 1
syscall
lw $a0, r+16
addi $a0, 1
syscall
la $v0, 1
la $a0, 7
syscall
la $v0, 11
la $a0, 10
syscall
la $v0, 3
mov.d $f12, $f0
syscall
la $v0, 10
syscall