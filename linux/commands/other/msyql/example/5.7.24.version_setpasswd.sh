
# 新版MySQL修改密码
use mysql
update user set authentication_string=password('123456') where user='root';
flush privileges;



