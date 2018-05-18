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
li $s1, 1
loop1:
bge $s1, 7, exit_loop
l.d $f2, 







exit_loop:

































