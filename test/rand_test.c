#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

int main(int argc, char **argv)
{
	int num = argc > 1 ? atoi(argv[1]) : 128;
	int *a, *b;
	a = malloc(sizeof(int)*num);
	b = malloc(sizeof(int)*num);
	srand((unsigned int)time(NULL));
	FILE *fp = fopen("/dev/sdb", "w+b");
        for(int i = 0; i < num; i++)
		a[i] = (int)rand();
       	int n = fwrite(a, sizeof(int)*num, 1, fp);
	printf("fwrite=%d(%lu)\n", n, sizeof(int)*num);
	fseek(fp, 0, SEEK_SET);
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

