#include <stdio.h>

/*多维数组*/

int main()
{

    /* 一个带有 5 行 2 列的数组 */
    int a[5][2] = { {0,0}, {1,2}, {3,4}, {5, 6}, {7, 8} };
    int i, j;

    /* 输出数组中每个元素的值 */
    for (i = 0; i < 5; i++)
    {
        for (j = 0; j < 2; j++)
        {
            printf("a[%d][%d] = %d\n", i, j, a[i][j]);
        }
    }

    return 0;

}
