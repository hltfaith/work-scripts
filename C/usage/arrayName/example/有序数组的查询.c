#include <stdio.h>
int main(){

    /*
     * 查询无序数组需要遍历数组中的所有元素，而查询有序数组只需要遍历其中一部分元素。例如有一个长度为 10 的整型数组，它所包含的元素按
     * 照从小到大的顺序（升序）排列，假设比较到第 4 个元素时发现它的值大于输入的数字，那么剩下的 5 个元素就没必要再比较了，
     * 肯定也大于输入的数字，这样就减少了循环的次数，提高了执行效率。
     *
     */

    int nums[10] = {0, 1, 6, 10, 23, 34, 100, 177, 296, 999};
    int i, num, thisindex = -1;

    printf("Input an integer: ");
    scanf("%d", &num);
    for(i=0; i<10; i++){
        if(nums[i] == num){
            thisindex = i;
            break;
        }else if(nums[i] > num){
            break;
        }
    }
    if(thisindex < 0){
        printf("%d isn't  in the array.\n", num);
    }else{
        printf("%d is  in the array, it's index is %d.\n", num, thisindex);
    }

    return 0;
}
