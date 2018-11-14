
## 增删改查 语法

## 增
#增加一张表
create table t1(id int,name char);
# 插入3条数据，规定id，name数据leilei
insert t1(id,name) values(1,"mjj01"),(2,"mjj02"),(3,"mjj03");

## 删
# 删除表
drop table t1;
#清空表<br>delete from t1;<br>#删除表
delete from t1 where id=2;

## 改
# modify修改的意思
alter table t1 modify name char(6);
# 改变name为大写的NAME
alter table t1 change name NAME char(7);
#修改表中的所有行，name等于zhang。非常危险，小心使用
update db1.t1 set name='zhang';
#修改id为2的行，name等于alex。推荐使用！
update db1.t1 set name='alex' where id=2;

##查
#只显示id字段<br>select id from db1.t1;<br>#执行显示2个字段
select id,name from db1.t1;<br>#查询所有字段
select * from db1.t1;
