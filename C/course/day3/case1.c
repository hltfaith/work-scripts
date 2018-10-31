#include <stdio.h>
int main(viod)
{
    /*
    //printf("hello, changhao!");

    // 4.*号的用法
    float a = 3.14;
    int b = 5;
    printf("%*.2f\n", b, a);



    float a = 3.14;
    int b = 5;
    int c = 2;
    printf("%-*.*f\n", b, c, a);
    printf("此结果");

    // 5.返回值的作用及用法
    float a = 3.15;
    int b;
    b = printf("%.2f\n", a);
    printf("%d\n", b);



    // 几个C语言的难题
    //1.下面这个程序的输出结果是什么？
    int i = 43;
    printf("%d\n", i);
    printf("%d\n", printf("%d", printf("%d", i)));

    //2.下面这个程序运行后，m和n的值是多少？
    int a = 4, b = 3, c = 2, d = 1, m = 2, n = 2;
    (m=a<b)&&(n=c>d);
    printf("m=%d, n=%d", m, n);

    // 3. 以下程序的输出结果是什么？
    int i;
    i = 10;
    printf("i: %d\n", i);
    printf("sizeof(i++) is: %d\n", sizeof(i++));
    printf("i: %d\n", i);


    // scanf专题：你可能不知道的scanf的用法
    //1>两个整数正常输入
    int a, b;
    int c;
    c = scanf("%d%d", &a, &b);
    printf("a = %d \nb = %d\nc = %d\n", a, b, c);


    //2>两个整数非正常输入
    int a, b;
    int c;
    c = scanf("%d%d", &a, &b);
    printf("a = %d \nb = %d\nc = %d\n", a, b, c);


    //3>两个整数带%*分隔正常输入

    int a, b;
    int c;
    printf("请输入a and b 值:");
    c = scanf("%d%*c%d", &a, &b);
    printf("a = %d \nb = %d\nc = %d\n", a, b, c);


    // getchar、getch、getche三者的区别
    //getchar函数，是C语言标准库中的函数，在头文件stdio中，可以接受用户输入的一个字符，回车结束，明文显示。

    char ch;
    ch = getchar();
    printf("%c\n", ch);

    */

    //getch函数，也是接收键盘输入的一个字符，但不用回车确认！使用时要包含conio的头文件
    char ch;
    ch = getch();
    printf("%c\n", ch);


















































    return 0;



}




