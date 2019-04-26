//
// Created by changhao on 19-4-26.
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void)
{

    char str1[100] = "The URL is";
    char str2[60];

    printf("Input a URL: ");
    fgets(str2, sizeof(str2), stdin);

    strcat(str1, str2);
    fputs(str1, stdout);

    return 0;

}

