//
// Created by changhao on 19-4-27.
//

#include <stdio.h>

int sum(int m, int n){
    int i, sum=0;
    for(i=m; i<=n; i++){
        sum+=i;
    }
    return sum;
}

int main()
{
    /*
     *
     * 如果函数需要接收用户传递的数据，那么定义时就要带上参数。如下所示：

        dataType  functionName( dataType1 param1, dataType2 param2 ... ){
            //body
        }
        dataType1 param1, dataType2 param2 ...是参数列表。函数可以只有一个参数，也可以有多个，
        多个参数之间由,分隔。参数本质上也是变量，定义时要指明类型和名称。与无参函数的定义相比，有参函数的定义仅仅是多了一个参数列表。

        数据通过参数传递到函数内部进行处理，处理完成以后再通过返回值告知函数外部。
     *
     *
     * */

    int result = sum(1, 100);
    printf("value: %d\n", result);

    return 0;

}

