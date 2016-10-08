#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char **argv)
{
	FILE *fp = fopen("/dev/sdb", "w+b");
	int num = argc > 1 ? atoi(argv[1]) : 128;
	int *b;
	b = (int*)malloc(sizeof(int)*num);
       	int m = fread(b, sizeof(int)*num, 1, fp);
	printf("fread=%d(%lu)\n", m, sizeof(int)*num);
	int error = 0;
        for(int i = 0; i < num; i++){
#ifdef DUMP
		printf(" %08x", b[i]);
		if(i % 8 == 7) printf("\n");
#endif
		if(0 != b[i]) error++;
	}
	printf("error=%d\n", error);
	free(b);
	fclose(fp);
}
