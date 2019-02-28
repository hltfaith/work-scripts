/*
数组Array
1.数组的创建方式 
字面量方式创建（推荐大家使用这种方式，简单粗暴）
*/

var colors = ['red','color','yellow'];
console.log(colors);

//使用for循环遍历数组
var colors = ['red','color','yellow'];
for (var i = 0;i < colors.length;i++){
    console.log(colors[i]);
}

//使用构造函数（后面会讲）的方式创建 使用new关键词对构造函数进行创建对象
var colors2 = new Array();
console.log(colors2)

/*
构造函数，必须要有关键字 new
函数名首字母大写
括号里面，也可以加变量

*/
var colors2 = new Array(1,2,3);
console.log(colors2)




