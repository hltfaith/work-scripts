

#永久修改/haha2的安全上下文，(/.*)指目录的所有文件，其中/haha2(/.*)?==/haha2/*
semanage fcontext -a -t public_content_t '/haha2(/.*)?'  

#内核记录过的/haha2安全上下文
semanage fcontext -l | grep /haha2 
