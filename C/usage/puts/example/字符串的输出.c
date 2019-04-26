#include <stdio.h>
int main(){
    char str[] = "http://c.biancheng.net";
    printf("%s\n", str);  //通过字符串名字输出
    printf("%s\n", "http://c.biancheng.net");  //直接输出
    puts(str);  //通过字符串名字输出
    puts("http://c.biancheng.net");  //直接输出
    return 0;
}

