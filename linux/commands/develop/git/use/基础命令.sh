
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


