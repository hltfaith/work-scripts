//
// Created by changhao on 19-4-26.
//
#include <stdio.h>
#include <string.h>
int main(){

    /*
     * strcpy() 会把 arrayName2 中的字符串拷贝到 arrayName1 中，字符串结束标志'\0'也一同拷贝。请看下面的例子：
     * */

    char str1[50] = "《C语言变怪兽》";
    char str2[50] = "http://c.biancheng.net/cpp/u/jiaocheng/";
    strcpy(str1, str2);
    printf("str1: %s\n", str1);
    return 0;
}
