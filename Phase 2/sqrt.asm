sqrt:
addi $s0, $zero, 0x1    #s0=x=1, x=float
add $s1, $zero, $zero   #s1=i=0

loop_sqrt:
div.d $f0, $a0, $s0     #t0=input/x          
add.d $f0, $f0, $a0     #t0= x+input/x
srl $s0, $f0, 0x1       #x=t0/2
addi $s1, $s1, 0x1      #i++
bne $s1, 10, loop_sqrt  #if i!=10, loop

add $f12, $zero, $s1     #v0=x
jr $ra                  #return