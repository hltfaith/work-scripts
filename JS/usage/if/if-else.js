
var ji  = 20;
if(ji>=20){
    console.log('恭喜你，吃鸡成功，大吉大利');
}else{
    console.log('很遗憾 下次继续努力');
 
}

/* 多层if-else  */
if (true) {
   //执行操作
}else if(true){
    //满足条件执行           
}else if(true){
   //满足条件执行       
}else{
  //满足条件执行
}

/*
    2.逻辑与&&、逻辑或||
    && 两个条件都成立的时候 才成立
*/

//1.模拟  如果总分 >400 并且数学成绩 >89分 被清华大学录入
//逻辑与&& 两个条件都成立的时候 才成立
if(sum>400 && math>90){
    console.log('清华大学录入成功')
}else{
    alert('高考失利')
}

//2.模拟 如果总分>400 或者你英语大于85 被复旦大学录入
//逻辑或  只有有一个条件成立的时候 才成立
if(sum>500 || english>85){
    alert('被复旦大学录入')
}else{
    alert('高考又失利了')
}

// 3.switch
var gameScore = 'better';
switch(gameScore){
//case表示一个条件 满足这个条件就会走进来 遇到break跳出。break终止循环。如果某个条件中不写 break，那么直到该程序遇到下一个break停止
    case 'good':
        console.log('玩的很好');
        //break表示退出
        break;
    case  'better':
        console.log('玩的老牛逼了');
        break;
    case 'best':
        console.log('恭喜你 吃鸡成功');
        break;
 
    default:
        console.log('很遗憾');
}





