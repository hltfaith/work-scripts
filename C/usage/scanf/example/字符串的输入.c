#include <stdio.h>
int main(){

    /*
     *
     *
     * 在C语言中，有两个函数可以让用户从键盘上输入字符串，它们分别是：

        scanf()：通过格式控制符%s输入字符串。除了字符串，scanf() 还能输入其他类型的数据。
        gets()：直接输入字符串，并且只能输入字符串。


       但是，scanf() 和 gets() 是有区别的：

        scanf() 读取字符串时以空格为分隔，遇到空格就认为当前字符串结束了，所以无法读取含有空格的字符串。
        gets() 认为空格也是字符串的一部分，只有遇到回车键时才认为字符串输入结束，所以，不管输入了多少个空格，只要不按下回车键，
         对 gets() 来说就是一个完整的字符串。换句话说，gets() 用来读取一整行字符串。

     *
     * */

    char str1[30] = {0};
    char str2[30] = {0};
    char str3[30] = {0};
    //gets() 用法
    printf("Input a string: ");
    gets(str1);
    //scanf() 用法
    printf("Input a string: ");
    scanf("%s", str2);
    scanf("%s", str3);

    printf("\nstr1: %s\n", str1);
    printf("str2: %s\n", str2);
    printf("str3: %s\n", str3);
    return 0;
}
