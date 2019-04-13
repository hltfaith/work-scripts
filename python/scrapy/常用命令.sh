
# 创建scrapy项目
scrapy startproject test1

# 进入到项目目录scrapy genspider 爬虫名字 爬虫的域名
scrapy genspider ncore12306 www.12306.cn

# 关于命令详细使用
echo "
命令的使用范围

这里的命令分为全局的命令和项目的命令，全局的命令表示可以在任何地方使用，而项目的命令只能在项目目录下使用

全局的命令有：
startproject
genspider
settings
runspider
shell
fetch
view
version

项目命令有：
crawl
check
list
edit
parse
bench
"


