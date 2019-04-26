
# 用fuser命令查看一下是哪些进程使用这个分区上的文件
fuser -v -m /home

# 如果没有什么重要的进程，用以下命令停掉它们：
fuser -k –v –m /usr

