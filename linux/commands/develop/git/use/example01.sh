

# 添加.gitignore 系统默认提供的git忽略提交的文件模板，设置.gitignore后将默认忽略指定目录/文件到仓库

git clone git@192.168.1.51:/opt/gitserver.git    #第一次使用，下载仓库
git add xxx.txt                          #添加上传文件
git commit -m "填写描述信息"             #添加描述信息
git push origin master			 #文件上传服务器
git pull origin master			 #文件下载或同步服务器
git rm  xxx.txt				 #文件删除
git commit -m '添加描述信息'         #添加描述信息
git push origin master		 #删除同步服务器


