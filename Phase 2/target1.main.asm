.data

arr: .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        .float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
dot: .word 0, 0
         .word 2, 6
         .word 8, 4
         .word 7, 2
         .word 1, 6
         .word 4, 9
         .word 3, 2
dist_min: .float 99999.0
dist: .float 0.0
course: .int 0, 0, 0, 0, 0, 0
d1: int 1
d2: int 1

.text
main:
la $a0, arr
la $a1, dot
j getPathLengthData

loop1:
addi $t0, $zero, 0x1  //t0=d1


for (int d1 = 1; d1 < 7; d1++)
        {
                dist = arr[0][d1];
                if (dist > dist_min)
                        continue;
                //depth2
                for (int d2 = 1; d2 < 7; d2++)
                {
                        if (d2 == d1)
                                continue;
                        dist = arr[0][d1] + arr[d1][d2];
                        if (dist > dist_min)
                                continue;
                        //depth3
                        for (int d3 = 1; d3 < 7; d3++)
                        {
                                if (d3 == d2 || d3 == d1)
                                        continue;
                                dist = arr[0][d1] + arr[d1][d2] + arr[d2][d3];
                                if (dist > dist_min)
                                        continue;
                                //depth4
                                for (int d4 = 1; d4 < 7; d4++)
                                {
                                        if (d4 == d3 || d4 == d2 || d4 == d1)
                                                continue;
                                        dist = arr[0][d1] + arr[d1][d2] + arr[d2][d3] + arr[d3][d4];
                                        if (dist > dist_min)
                                                continue;
                                        //depth5
                                        for (int d5 = 1; d5 < 7; d5++)
                                        {
                                                if (d5 == d4 || d5 == d3 || d5 == d2 || d5 == d1)
                                                        continue;
                                                dist = arr[0][d1] + arr[d1][d2] + arr[d2][d3] + arr[d3][d4] + arr[d4][d5];
                                                if (dist > dist_min)
                                                        continue;
                                                //depth6
                                                for (int d6 = 1; d6 < 7; d6++)
                                                {
                                                        if (d6 == d5 || d6 == d4 || d6 == d3 || d6 == d2 || d6 == d1)
                                                                continue;
                                                        dist = arr[0][d1] + arr[d1][d2] + arr[d2][d3] + arr[d3][d4] + arr[d4][d5] + arr[d5][d6] + arr[d6][0];
                                                        if (dist < dist_min)
                                                        {
                                                                course[0] = d1;
                                                                course[1] = d2;
                                                                course[2] = d3;
                                                                course[3] = d4;
                                                                course[4] = d5;
                                                                course[5] = d6;
                                                                dist_min = dist;
                                                        }
                                                }
                                        }
                                }
                        }
                }
        }
        printf("1 %d %d %d %d %d %d 1\n%lf\n", course[0]+1, course[1]+1, course[2]+1, course[3]+1, course[4]+1, course[5]+1, dist_min);
}
