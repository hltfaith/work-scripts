

# 使用标签来改变安全上下文： 
chcon -t httpd_system_content_t /var/www/html/index.html

# 使用参考文件的标签来改变安全上下文：
chcon --reference /var/www/html/ /var/www/html/index.html

