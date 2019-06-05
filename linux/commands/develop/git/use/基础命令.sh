
# 初始化 git 服务
git config --global user.name "你的名字或昵称"
git config --global user.email "你的邮箱"

git add . #将当前目录所有文件添加到git暂存区
git commit -m "my first commit" #提交并备注提交信息
git push origin master #将本地提交推送到远程仓库

branch常用的命令：
git branch -a #查看本地和远程所有的分支
git branch -r #查看所有远程分支
git branch #查看所有本地分支
git branch -d -r origin/branchA #删除远程分支

可以使用git merge命令或者git rebase命令，在本地分支上合并远程分支。
git merge origin/master
# 或者
git rebase origin/master

# 对比差异
# 先更新下本地的远程分支
git fetch origin

# 然后可以比对
git diff 本地分支 origin/xxxx


