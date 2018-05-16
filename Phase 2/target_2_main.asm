.data:
	dot:	.word 0 0 0 0 2 6 8 4
			.word 7 2 1 6 4 9 3 2

	arr:	.float 0 0 0 0 0 0 0 0
			.float 0 0 0 0 0 0 0 0
			.float 0 0 0 0 0 0 0 0
			.float 0 0 0 0 0 0 0 0
			.float 0 0 0 0 0 0 0 0
			.float 0 0 0 0 0 0 0 0
			.float 0 0 0 0 0 0 0 0
			.float 0 0 0 0 0 0 0 0
	dist:	.float 0
	min:	.float 99999
	r:		.word 1 0 0 0 0 0 7
	save_root:	.word 0 0 0 0 0 0 0

.text

.loop1
addi $t0, $zero, 0x2   //t0=a, a=2
l.s $s0, dist          // s0=dist
la $s1, r              // s1=r
add.s $s0, $zero, $zero //dist=0
sw $t0, 0x4($s1)        // r[1]=a
la $s2, arr				// s2=arr

.loop2
addi $t1, $zero, 0x2



	for (int a = 2; a <= 6; a++){
		dist = 0;
		r[1] = a;
		dist = arr[r[0]][r[1]];
		//depth 2;
		for (int b = 2; b <= 6; b++){
			r[2] = b	;
	if (a == b){
				continue;
			}
			dist = arr[r[0]][r[1]] + arr[r[1]][r[2]];
			if (dist > min) continue;
			//depth 3
			for (int c = 2; c <= 6; c++){
				r[3] = c;
				if (a == c || b == c){
					continue;
				}
				dist = arr[r[0]][r[1]] + arr[r[1]][r[2]] + arr[r[2]][r[3]];
				if (dist > min) continue;
				//depth 4
				for (int d = 2; d <= 6; d++){
					r[4] = d;
					if (a == d || b == d || c == d){
						continue;
					}
					dist = arr[r[0]][r[1]] + arr[r[1]][r[2]] + arr[r[2]][r[3]] + arr[r[3]][r[4]];
					if (dist > min) continue;
					//depth 5
					for (int e = 2; e <= 6; e++){
						r[5] = e;
						if (a == e || b == e || c == e|| d == e){
							continue;
						}
						dist = arr[r[0]][r[1]] + arr[r[1]][r[2]] + arr[r[2]][r[3]] + arr[r[3]][r[4]] + arr[r[4]][r[5]] + arr[r[5]][r[6]];
						if (dist < min){
							for (int i = 0; i < 7; i++){
								save_route[i] = r[i];
								min = dist;
							}
						}
					}
				}
			}
		}
	}
	for (int i = 0; i < 7; i++) {
		printf("%d ",save_route[i]);
	}
	printf("\n%f", min);
}
