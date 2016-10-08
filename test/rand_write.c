#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

int main(int argc, char **argv)
{
	int num = argc > 1 ? atoi(argv[1]) : 128;
	int seed = argc > 2 ? atoi(argv[2]) : 0;
	printf("seed=%d\n", seed);
	srand(seed);
	int *a;
	a = malloc(sizeof(int)*num);
	FILE *fp = fopen("/dev/sdb", "wb");
        for(int i = 0; i < num; i++)
		a[i] = (int)rand();
       	int n = fwrite(a, sizeof(int)*num, 1, fp);
	printf("fwrite=%d(%lu)\n", n, sizeof(int)*num);
	fclose(fp);
	free(a);
}
