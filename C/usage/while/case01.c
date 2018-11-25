#include <stdio.h>
int main(void)
{

	// while 循环使用方法
	int i = 0;
	while (i++ < 10)
	{
		printf("count %d\n", i);
	}

	// do while语句
	int i = 0;
	do
	{
		printf("count %d\n", i++);
	} while (i < 20);
  
	system("pause");
}

