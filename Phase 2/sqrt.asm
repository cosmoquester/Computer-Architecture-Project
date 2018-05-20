.data
    zero:   .double 0.0
    x:      .double 0.0
    two:    .double 2.0
.text

sqrt:
mtc1.d $a0, $f12
cvt.d.w $f12, $f12
l.d $f2,zero 
add $s1, $zero, $zero   #s1=i=0

loop_sqrt:
div.d $f4, $f12, $f2    #f4=input/x          
add.d $f4, $f4, $f12     #f4= x+input/x
l.d $f6, two
div.d $f2, $f4, $f6     #x=f4/2
addi $s1, $s1, 0x1      #i++
bne $s1, 10, loop_sqrt  #if i!=10, loop

s.d $f2, x
l.d $f0, x              #f0=x
jr $ra                  #return