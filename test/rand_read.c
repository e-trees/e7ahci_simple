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
	int *a, *b;
	a = malloc(sizeof(int)*num);
	b = malloc(sizeof(int)*num);
	FILE *fp = fopen("/dev/sdb", "rb");
        for(int i = 0; i < num; i++)
		a[i] = (int)rand();
       	int m = fread(b, sizeof(int)*num, 1, fp);
	printf("fread=%d(%lu)\n", m, sizeof(int)*num);
	int error = 0;
        for(int i = 0; i < num; i++){
#ifdef DUMP
		printf(" %08x", b[i]);
		if(i % 8 == 7) printf("\n");
#endif
		if(a[i] != b[i]) error++;
	}
	printf("error=%d\n", error);
	fclose(fp);
	free(a);
	free(b);
}
