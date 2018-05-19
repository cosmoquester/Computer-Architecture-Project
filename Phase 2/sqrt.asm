sqrt:
addi.d $f2, $zero, 0x1  #f2=x=1, x=float
add $s1, $zero, $zero   #s1=i=0

loop_sqrt:
div.d $f4, $a0, $f2     #f4=input/x          
add.d $f4, $f4, $a0     #f4= x+input/x
srl $f2, $f4, 0x1       #x=f4/2
addi $s1, $s1, 0x1      #i++
bne $s1, 10, loop_sqrt  #if i!=10, loop

add $f0, $zero, $s1     #f0=x
jr $ra                  #return