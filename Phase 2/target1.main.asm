.data

arr: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
dot: .int 0, 0
         .int 2, 6
         .int 8, 4
         .int 7, 2
         .int 1, 6
         .int 4, 9
         .int 3, 2
dist_min: .float 99999.0
dist: .float 0.0
course: .int 0, 0, 0, 0, 0, 0
d1: int 1
d2: int 1

.text
.global	main
main:
la $a0, arr
la $a1, dot

