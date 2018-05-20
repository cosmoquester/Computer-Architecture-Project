.data
    zero:   .double 0.0
    x:      .double 1.0
    two:    .double 2.0
.text
#레지스터 표-----
#   $a0 함수 인자
#   $s1 = i 반복문 카운터
#   $f2 = x
#   $f4 = tmp 임시변수
#   $f6 = 2(상수의 더블 형)
#----------------------------
sqrt:
mtc1 $a0, $f12
cvt.d.w $f12, $f12
l.d $f2, x
l.d $f6, two
add $s1, $zero, $zero   #s1=i=0

loop_sqrt:
div.d $f4, $f12, $f2    #f4=input/x          
add.d $f4, $f4, $f2     #f4= x+input/x
div.d $f2, $f4, $f6    #x=f4/2
addi $s1, $s1, 0x1      #i++
bne $s1, 10, loop_sqrt  #if i!=10, loop

#add.d $f12, $f8, 0.0
s.d $f2, x
l.d $f12, x
jr $ra                  #return