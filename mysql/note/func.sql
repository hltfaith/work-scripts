
# 查看字节数
## length()
# 查看字节数
#char类型：3个中文字符+2个空格=11Bytes
#varchar类型:3个中文字符+1个空格=10Bytes
select x,length(x),y,length(y) from t1;

# 查看字符数
## char_length()

# 在检索时char很不要脸地将自己浪费的2个字符给删掉了，装的好像自己没浪费过空间一样，而varchar很老实，存了多少，就显示多少
select x,char_length(x),y,char_length(y) from t1;
+-----------+----------------+------------+----------------+
| x         | char_length(x) | y          | char_length(y) |
+-----------+----------------+------------+----------------+
| 你瞅呢    |              3 | 你瞅啥     |              4 |
+-----------+----------------+------------+----------------+

#查看当前mysql的mode模式
select @@sql_mode;

























