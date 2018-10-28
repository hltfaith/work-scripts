#include <stdio.h>
int main()
{
    //四种printf的用法想必大家都应该很熟悉, 各种\n、\t 、\r、\b等转义字符不再讲解，大家可自行查表。

    /*
    int a = 99;
    char b = 'w';
    double c = 3.14165;
    char str[100] = "www.dotcpp.com";

    printf("%d\n", a);      //print 整数
    printf("%c\n", b);      //print 字符
    printf("%f\n", c);      //print 浮点数
    printf("%s\n", str);    //print 字符串
    return 0;
    */

    //1.多进制转换功能  十进制对应的八进制、十六进制数
    /*
    int a = 99;
    printf("%d %o %x\n", a, a, a);
    return 0;
    */


    //2.控制输出占位宽、左右对齐。  以%d为例，我们输出的数字默认都是以实际占位输出
    /*
    int a = 1;
    while (a<100000)
    {
        printf("%d \n", a);
        a = a*10;
    }

    //当我们想以每个数字都用固定的宽度输出时，可以在%和d之间加一个数来表示位宽，比如占10位，则写成%10d


    int aa = 1;
    while(aa<100000)
    {
        printf("%10d\n",aa);
        aa = aa*10;
    }

    return 0;
    */

    //3.小数位数控制  定义float和double类型时，有没有遇到过这样的情形
    /*
    float a = 3.14;
    printf("%f \n", a);
    */

    //浮点数a只有两位有效小数，而%f默认输出6位，就会有多余的4个0，我不想要怎么办？答：控制小数位数。 怎么控制？%和f之间加.2即可，变成%.2f，
    /*
    printf("%.2f\n", a);
    */

    //如果保留5位就%.5f以此类推，并且可以和上面讲的控制位宽和对齐方向同时使用
    /*
    float a2 = 3.14;
    printf("%5.2f\n");
    */

    //4.*号的用法   在printf里可以代表一个泛整数，可以代表任何整数。它可以出现在位宽的位置，也可以出现在小数位数的位置。
    //但在printf的双引号外面，必须要有*对应的数值。
    //比如我的位宽不确定，想用整数a表示，则可以写成：
    /*
    float a3 = 3.14;
    int b3 = 5;
    printf("%*.2f\n", b3,a3);
    return 0;
    */

    //几个C语言的难题
    //1.下面这个程序的输出结果是什么？

    /*
    int i = 43;
    printf("%d \n", printf("%d", printf("%d", i)));
    return 0;
    */

    //参考答案：本程序将输出4321。原因在于先输出i的值为43然后紧接着输出printf的返回值!而printf的返回值为输出的字符的个数！
    //所以呢再执行完最里面的printf(“%d”,i)打印43之后，接着打印printf(“%d”,43)这句话的返回值即2，然后在打印printf(“%d”,2)的返回值即1.所以最后结果为4321


}









































































