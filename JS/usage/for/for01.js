
//i的初始值为1,i<=10,i自增1
for(var i = 1;i<=10;i++){  
    console.log(i);
}

/*
课堂练习：

1~100之间的偶数
*/
for(var i = 1;i<=100;i++){
    if(i%2==0){
        //是偶数
        console.log(i);
    }
}

//1-100之间所有数之和
var sum = 0;
for(var j = 1;j<=100;j++){
    sum = sum+j;
}
console.log(sum);

//双重fo循环
for(var i=1;i<=3;i++){
             
 　　for(var j=0;j<6;j++){
        document.write('*');
    }
             
   document.write('<br>');
 }

