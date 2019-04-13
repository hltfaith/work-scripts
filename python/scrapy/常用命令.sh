
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

# genspider
# 用于生成爬虫，这里scrapy提供给我们不同的几种模板生成spider,默认用的是basic,我们可以通过命令查看所有的模板
scrapy genspider -l


# check 用于检查代码是否有错误
scrapy check

# list 列出所有可用的爬虫
scrapy list

# fetch 该命令会通过scrapy downloader 讲网页的源代码下载下来并显示出来
scrapy fetch url地址 
canshu="
这里有一些参数：
--nolog 不打印日志
--headers 打印响应头信息
--no-redirect 不做跳转"

# view 该命令会讲网页document内容下载下来，并且在浏览器显示出来
scrapy view url地址

# settings 获取当前的配置信息
scrapy settings -h



















