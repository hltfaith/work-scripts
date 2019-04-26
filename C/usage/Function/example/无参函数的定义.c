//
// Created by changhao on 19-4-27.
//

#include <stdio.h>

int sum()
{

    /*
     *
     * 无参函数的定义
        如果函数不接收用户传递的数据，那么定义时可以不带参数。如下所示：

        dataType  functionName(){
            //body
        }

        dataType 是返回值类型，它可以是C语言中的任意数据类型，例如 int、float、char 等。
        functionName 是函数名，它是标识符的一种，命名规则和标识符相同。函数名后面的括号( )不能少。
        body 是函数体，它是函数需要执行的代码，是函数的主体部分。即使只有一个语句，函数体也要由{ }包围。
        如果有返回值，在函数体中使用 return 语句返回。return 出来的数据的类型要和 dataType 一样。

     * */

    int i, sum = 0;
    for(i=1; i<=100; i++){
        sum+=i;
    }
    return sum;

}

int main(){

    int a = sum();
    printf("The sum is %d\n", a);

    return 0;

}