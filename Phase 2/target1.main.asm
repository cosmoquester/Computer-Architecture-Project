.data

arr: .double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
dot: .word 0, 0
         .word 2, 6
         .word 8, 4
         .word 7, 2
         .word 1, 6
         .word 4, 9
         .word 3, 2    
course: .word 0, 0, 0, 0, 0, 0


# d1 ~ d6 = s1 ~ s6
# f0 = dist_min, f2=dist

.text
main:
l.d $f0, 99999
l.d $f1, 0
# GetPathLenthData funciton excution
la $a0, arr
la $a1, dot
jal getPathLengthData

# for loop1
li $s1, 0
loop1:
addi $s1, $s1, 1
bge $s1, 7, exit_loop
sll $t0, $s1, 3
add $t0, $t0, arr
mtc1 $t0, $f2                 # dist = arr[0][d1]
c.le.d $f0, $f2 
bc1t loop1                    # if (dist > dist_min)    continue;	
# for loop2
li $s2, 0
loop2:
addi $s2, $s2, 1
bge $s2, 7, loop1
sll $t0, $s2, 3
add $t0, $t0, arr
mtc1 $t0, $f2                 # dist = arr[0][d1]
c.le.d $f0, $f2 
bc1t loop2                    # if (dist > dist_min)    continue;


exit_loop: