
# 清空表但不删除表，保留表结构
truncate table t1;

# 求救语法：
help create database;

##数据库命名规则：　
# 可以由字母、数字、下划线、＠、＃、＄
# 区分大小写
# 唯一性
# 不能使用关键字如 create select
# 不能单独使用数字
# 最长128位
# 基本上跟python或者js的命名规则一样

# 查看数据库
show databases;

# 查看当前库
show create database db1;

# 选择数据库
use db1;

# 查看当前所在的库
select database();

# 删除数据库
drop database db1;

# 修改数据库字符集
alter database db1 charset utf8;

## 需要了解
## SQL语言主要用于存取数据、查询数据、更新数据和管理关系数据库系统,SQL语言由IBM开发。SQL语言分为3种类型：
#1、DDL语句    数据库定义语言： 数据库、表、视图、索引、存储过程，例如CREATE DROP ALTER
 
#2、DML语句    数据库操纵语言： 插入数据INSERT、删除数据DELETE、更新数据UPDATE、查询数据SELECT
 
#3、DCL语句    数据库控制语言： 例如控制用户的访问权限GRANT、REVOKE

# 查看所有支持的引擎
show engines；

# 查看正在使用的存储引擎
 show variables like '%storage_engine%';

# 指定表类型/存储引擎
create table t1(id int)engine=innodb;

# 创建四张表，分别使用innodb,myisam,memory,blackhole存储引擎，进行插入数据测试 
create table t1(id int)engine=innodb;
create table t2(id int)engine=myisam;
create table t3(id int)engine=memory;
create table t4(id int)engine=blackhole;

# .frm是存储数据表的框架结构
 
# .ibd是mysql数据文件
 
# .MYD是MyISAM表的数据文件的扩展名
 
# .MYI是MyISAM表的索引的扩展名
 
# 发现后两种存储引擎只有表结构，无数据
 
# memory，在重启mysql或者重启机器后，表内数据清空
# blackhole，往表内插入任何数据，都相当于丢入黑洞，表内永远不存记录

# 创建表
create table 表名(
字段名1 类型[(宽度) 约束条件],
字段名2 类型[(宽度) 约束条件],
字段名3 类型[(宽度) 约束条件]
);
 
#注意：
1. 在同一张表中，字段名是不能相同
2. 宽度和约束条件可选
3. 字段名和类型是必须的





































