# tmux的常规运维命令
1）安装命令：　
[root@Centos6 ~]# yum -y install tmux
　　
2）默认创建一个会话，以数字命名。（不推荐）
[root@Centos6 ~]# tmux
　　
3）新建会话，比如新创建一个会话以"ccc"命名
[root@Centos6 ~]# tmux new -s ccc
 
加上参数-d，表示在后台新建会话
root@bobo:~# tmux new -s shibo -d
root@bobo:~# tmux ls
shibo: 1 windows (created Tue Oct  2 19:22:32 2018) [135x35]
 
4）查看创建得所有会话
[root@Centos6 ~]# tmux ls
0: 1 windows (created Wed Aug 30 17:58:20 2017) [112x22](attached)    #这里的attached表示该会话是当前会话
aaa: 2 windows (created Wed Aug 30 16:54:33 2017) [112x22]
ccc: 1 windows (created Wed Aug 30 17:01:05 2017) [112x22]
   
5）登录一个已知会话。即从终端环境进入会话。
第一个参数a也可以写成attach。后面的aaa是会话名称。
[root@Centos6 ~]# tmux a -t aaa 
　　
6）退出会话不是关闭：
登到某一个会话后，依次按键ctrl-b + d，这样就会退化该会话，但不会关闭会话。
如果直接ctrl + d，就会在退出会话的通话也关闭了该会话！
   
7）关闭会话（销毁会话）
[root@Centos6 ~]# tmux ls
aaa: 2 windows (created Wed Aug 30 16:54:33 2017) [112x22]
bbb: 1 windows (created Wed Aug 30 19:02:09 2017) [112x22]
   
[root@Centos6 ~]# tmux kill-session -t bbb
   
[root@Centos6 ~]# tmux ls
aaa: 2 windows (created Wed Aug 30 16:54:33 2017) [112x22]
  
8）重命名会话
[root@Centos6 ~]# tmux ls  
wangshibo: 1 windows (created Sun Sep 30 10:17:00 2018) [136x29] (attached)
  
[root@Centos6 ~]# tmux rename -t wangshibo kevin
  
[root@Centos6 ~]# tmux ls
kevin: 1 windows (created Sun Sep 30 10:17:00 2018) [136x29] (attached)


