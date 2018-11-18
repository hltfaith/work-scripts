#include <stdio.h>
int main()
{
    int a, b;
    printf("Please enter two numbers:");
    scanf("%d,%d", &a, &b);
    if(a<b)
        a = b;
    printf("the bigger one is: %d\n", a);
    return 0;
}
