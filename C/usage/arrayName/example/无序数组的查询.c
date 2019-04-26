#include <stdio.h>
int main(void)
{
    /*
     *
     *  对无序数组的查询
        所谓无序数组，就是数组元素的排列没有规律。无序数组元素查询的思路也很简单，
        就是用循环遍历数组中的每个元素，把要查询的值挨个比较一遍。请看下面的代码：
     *
     */

    int nums[10] = {1, 10, 6, 296, 177, 23, 0, 100, 34, 999};
    int i, num, thisindex = -1;

    printf("Input an integer: ");
    scanf("%d", &num);

    for(i=0; i<10; i++){

        if(nums[i] == num){
            thisindex = i;
            break;
        }
    }

    if(thisindex <0 ){
        printf("%d isn't in the array.\n", num);
    }else{
        printf("%d is in the array, it's index is %d.\n", num, thisindex);
    }

}
