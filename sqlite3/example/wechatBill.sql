
-- sqlite3

-- 创建表结构
-- 交易时间 交易类型 	交易对方	商品	收/支	金额(元)	支付方式	当前状态	交易单号	商户单号	备注
-- JYSJ      JYLX        JYDF    SP    SZ    JE          ZFFS      DQZT      JYDH      SPDH      BZ
CREATE TABLE BILL(
   ID INT PRIMARY KEY     NOT NULL,
   JYSJ           DATETIME,
   JYLX           TEXT,
   JYDF           TEXT,
   SP             TEXT,
   SZ             TEXT,
   JE             INT,
   ZFFS           TEXT,
   DQZT           TEXT,
   JYDH           TEXT,
   SPDH           TEXT,
   BZ             TEXT
);

-- 设置print格式
.header on
.mode column
.width 30, 10, 50, 50

-- 查询表
.tables
.databases
.schema bill
select * from BILL;

-- 删除表
drop table BILL;

-- 删除数据
  delete from bill where JYSJ = '2019-03-10 01:11:17';
  delete from bill where JYSJ = '2019-02-28 00:36:04';
  delete from bill where JYSJ = '2019-02-28 00:11:32';

  -- 删除2019-02-25日期数据
  delete from bill where strftime('%Y-%m-%d', JYSJ) == "2019-02-25";


-- 数据查询语句
-- 查询时间
SELECT JYSJ FROM BILL;
select JYSJ from bill where datetime(JYSJ);

select max(JYSJ) from bill;
select strftime('%H:%M:%S') from bill where datetime(JYSJ) >= '2019-03-11';
select strftime('%H:%M:%S') from bill where JYSJ;
select strftime('%H:%M:%S',JYSJ) from bill where datetime(JYSJ) >= '2019-03-11';
select strftime('%H:%M:%S',JYSJ) from bill where strftime('%H:%M:%S',JYSJ) <= '12:00:00';

-- 最晚一次消费的时间
select max(JYSJ) from bill where strftime('%H:%M:%S',JYSJ) < '06:00:00';
select strftime('%Y-%m-%d ', JYSJ) || max(strftime('%H:%M:%S',JYSJ)) from bill where strftime('%H:%M:%S',JYSJ) < '24:00:00';

  -- 早上时间段消费多少笔06:00~09:30
  select count(JYSJ) from bill where strftime('%H:%M:%S',JYSJ) between '06:00:00' and '09:30:00';
  -- 中午时间段消费多少笔11:00~13:30
  select count(JYSJ) from bill where strftime('%H:%M:%S',JYSJ) between '11:00:00' and '13:30:00';
  -- 晚上时间段消费多少笔18:00~24:00
  select count(JYSJ) from bill where strftime('%H:%M:%S',JYSJ) between '18:00:00' and '23:59:59';

-- 查询价格
-- 查询最高消费金额
  select max(JE) from bill;
-- 查询最高消费金额，日期
  select JYSJ from BILL where JE == (select max(JE) from bill);

-- 平均每天至少消费几次
  select ((select count(JYSJ) from bill) / (select count(distinct strftime('%Y-%m-%d',JYSJ)) from bill));
  -- 天数
  select count(distinct strftime('%Y-%m-%d',JYSJ)) from bill;
  -- 总次数
  select count(JYSJ) from bill;

-- 其中几天没有消费
  -- 消费的日期
  select distinct strftime('%Y-%m-%d',JYSJ) from bill;
  -- 起止日期
  select min(distinct strftime('%Y-%m-%d',JYSJ)) from bill;
  -- 结束日期
  select max(distinct strftime('%Y-%m-%d',JYSJ)) from bill;

-- 平均每天消费多少金额
  -- 月总支出
  select SUM(JE) from bill where SZ='支出';
  -- 每天平均消费金额
  select ((select SUM(JE) from bill where SZ='支出') / (select count(distinct strftime('%Y-%m-%d',JYSJ)) from bill));

-- 统计扫码支付次数
  select count(JYLX) from bill where JYLX = '扫二维码付款';

-- 微信红包
  -- 收次数
  select count(*) from bill where JYLX = '微信红包' and SZ = '收入';
  -- 发次数
  select count(*) from bill where JYLX = '微信红包' and SZ = '支出';
  -- 收到红包最大金额
  select max(JE) from bill where JYLX = '微信红包' and SZ = '收入';
  -- 发送红包最大金额
  select max(JE) from bill where JYLX = '微信红包' and SZ = '支出';
  -- 转账次数
  select count(*) from bill where JYLX = '转账';
  -- 转最大金额
  select max(JE) from bill where JYLX = '转账' and SZ = '支出';
  -- 收最大金额
  select max(JE) from bill where JYLX = '转账' and SZ = '收入';



-- 钱去了哪里
  --
  select distinct SP from bill;


-- 美食
  -- 最爱吃的东西
  select SP from bill where SP LIKE '%外卖订单';

  -- 最爱玩的地方
  select JYDF from bill;

-- 生活
  -- 预测所在位置
  select JYDF from bill where  JYDF NOT like '%外卖%' and NOT JYDF == '上海拉扎斯信息科技有限公司';

  -- 预测每周固定做的事情
  select strftime('%Y-%m-%d',JYSJ),strftime('%w',JYSJ), JYDF, SP from bill;
  select strftime('%Y-%m-%d',JYSJ),strftime('%w',JYSJ), JYDF, SP from bill where NOT JYDF == '/' and NOT SP == '/';

  -- 计算当年 10 月的第一个星期二的日期：
  select strftime('%w',JYSJ) from BILL;

  -- 预测特别的一天
    /**
    评判标准
    1. 当天消费最高
    2. 消费数量最多
    3. 当天收到红包数量 >= 10
    4. 生日
     */

    -- 生日
    select strftime('%Y-%m-%d',JYSJ) from bill where JYDF LIKE '%生日%' or JYDF LIKE '%蛋糕%' or SP LIKE '%生日%' or SP LIKE '%蛋糕%' LIMIT 1;

    select strftime('%Y-%m-%d',JYSJ) from bill
        where
              JYDF LIKE '%生日%'
              or JYDF LIKE '%蛋糕%'
              or SP LIKE '%生日%'
              or SP LIKE '%蛋糕%'
        LIMIT 1;

    -- 收到红包
    select strftime('%Y-%m-%d',JYSJ), Count(strftime('%Y-%m-%d',JYSJ)) from bill
        where
              JYLX == '微信红包'
        group by strftime('%Y-%m-%d',JYSJ)
        ORDER BY COUNT(strftime('%Y-%m-%d',JYSJ))
        DESC LIMIT 1;

    -- 消费数量最多
    select strftime('%Y-%m-%d',JYSJ),Count(strftime('%Y-%m-%d',JYSJ)) from bill
        group by strftime('%Y-%m-%d',JYSJ)
        ORDER BY COUNT(strftime('%Y-%m-%d',JYSJ))
        DESC LIMIT 1;

    -- 当天消费最高
    select strftime('%Y-%m-%d',JYSJ),SUM(JE) from bill GROUP BY strftime('%Y-%m-%d',JYSJ) ORDER BY SUM(JE) DESC LIMIT 1;
    select count(strftime('%Y-%m-%d',JYSJ),SUM(JE) from bill GROUP BY strftime('%Y-%m-%d',JYSJ)

-- test
  select (select count(JYDF) from bill where JYDF LIKE '%滴滴%'),(select count(SP) from bill where SP LIKE '%地铁%' or JYDF LIKE '%北京轨道交通%');




-- 日常生活

  -- 滴滴 地铁 外卖 医院 垃圾食品 飞机 酒店 购物 美食 其他
  -- [4, 10, 10, 0, 4, 3, 1, 4, 9, 71]

  -- 滴滴打车次数
  select count(JYDF) from bill where JYDF LIKE '%滴滴%';

  -- 乘坐地铁次数
  select count(SP) from bill where SP LIKE '%地铁%' or JYDF LIKE '%北京轨道交通%';

  -- 外卖订单次数
  select count(SP) from bill where SP LIKE '%外卖%' or JYDF LIKE '%上海拉扎斯信息科技有限公司%';

  -- 医院看病次数
  select count(SP) from bill where SP LIKE '%医院%' or JYDF LIKE '%医院%' or JYDF LIKE '%门诊%';

  -- 垃圾食品次数
  select count(SP) from bill where  JYDF LIKE '%麦当劳%' or JYDF LIKE '%肯德基%' or JYDF LIKE '%辣条%';

  -- 飞机出行次数
  select COUNT(SP) from BILL where SP LIKE '%机票%' or SP LIKE '%飞机%' or SP LIKE '%航空%';

  -- 酒店次数
  select COUNT(SP) from bill where SP LIKE '%酒店%' or JYDF LIKE '%酒店%' or SP LIKE '%宾馆%' or JYDF LIKE '%宾馆%';

  -- 购物次数
  select count(SP) from bill where SP LIKE '%商场%' or JYDF LIKE '%商店%' or JYDF LIKE '%超市%' or JYDF LIKE '%便利店%';

  -- 美食次数
  select count(SP) from bill where SP LIKE '%饭店%' or JYDF LIKE '%小吃%' or JYDF LIKE '%美食%' or SP LIKE '%面%' or SP LIKE '%饭%';

  -- 其他次数
  select count(SP) from bill
        where
              NOT JYDF LIKE '%滴滴%'
              AND NOT SP LIKE '%地铁%'
              AND NOT JYDF LIKE '%北京轨道交通%'
              AND NOT SP LIKE '%外卖%'
              AND NOT JYDF LIKE '%上海拉扎斯信息科技有限公司%'
              AND NOT SP LIKE '%医院%'
              AND NOT JYDF LIKE '%医院%'
              AND NOT JYDF LIKE '%门诊%'
              AND NOT JYDF LIKE '%麦当劳%'
              AND NOT JYDF LIKE '%肯德基%'
              AND NOT JYDF LIKE '%辣条%'
              AND NOT SP LIKE '%机票%'
              AND NOT SP LIKE '%飞机%'
              AND NOT SP LIKE '%航空%'
              AND NOT SP LIKE '%酒店%'
              AND NOT JYDF LIKE '%酒店%'
              AND NOT SP LIKE '%宾馆%'
              AND NOT JYDF LIKE '%宾馆%'
              AND NOT SP LIKE '%商场%'
              AND NOT JYDF LIKE '%商店%'
              AND NOT JYDF LIKE '%超市%'
              AND NOT JYDF LIKE '%便利店%'
              AND NOT SP LIKE '%饭店%'
              AND NOT JYDF LIKE '%小吃%'
              AND NOT JYDF LIKE '%美食%'
              AND NOT SP LIKE '%面%'
              AND NOT SP LIKE '%饭%';

  -- 4|10|10|0|4|3|1|4|9|71




-- 足迹
  -- 城市足迹, 10个活跃的地点
  select JYDF from bill
      where
            NOT JYDF == '/'
            and  JYDF NOT like '%上海拉扎斯信息科技有限公司%'
            and  JYDF NOT like '%银行%'
            and  JYDF NOT like '%北京轨道交通%'
            and  JYDF NOT like '%携程%'
            and  JYDF NOT like '%手机充值%'
            and  JYDF NOT like '%滴滴%'
      group by JYDF ORDER BY count(JYDF) DESC;


-- 交易时间 交易类型 	交易对方	商品	收/支	金额(元)	支付方式	当前状态	交易单号	商户单号	备注
-- JYSJ      JYLX        JYDF    SP    SZ    JE          ZFFS      DQZT      JYDH      SPDH      BZ



-- 页面前端

-- 支出明细
  -- 需求： 消费商品  交易类型   金额   支付日期   交易单号
  select ID,SP,JYLX,JE,JYSJ,JYDH from bill;

-- 支出预览
  -- 需求： 总支出,  最高支出 占 百分之几   | 总收入,  最高收入 占 百分之几
    -- 总支出
    select SUM(JE) from BILL where SZ == '支出';

    -- 总收入
    select SUM(JE) from BILL where SZ == '收入';

    -- 单笔最高支出
    select max(JE) from bill where SZ == '支出';

    -- 单笔最高收入
    select max(JE) from bill where SZ == '收入';

    -- 单笔最高支出 占 百分之几
    select((select max(JE) from bill where SZ == '支出') / (select SUM(JE) from BILL where SZ == '支出'));

    -- 单笔最高收入 占 百分之几
    select((select max(JE) from bill where SZ == '收入') / (select SUM(JE) from BILL where SZ == '收入'));

    -- 总支出 占 收支 百分之几
    select((select SUM(JE) from BILL where SZ == '支出') /
        (select SUM(JE) from bill where SZ == '收入' or SZ == '支出'));

    -- 总收入 占 收支 百分之几
    select((select SUM(JE) from BILL where SZ == '收入') / (select SUM(JE) from bill where SZ == '收入' or SZ == '支出'));

  -- 共 多少 条记录
  select COUNT(ID) from bill;


-- 消费分类
  -- 美食
  -- 交通
  -- 娱乐
  -- 生活
  -- 电子产品
    select JYDF from BILL where NOT JYDF == '/';

-- 近一周消费
  -- 最近七天 获取每天消费金额
  -- 总查询
    select strftime('%m-%d',JYSJ),sum(JE) from bill group by strftime('%m-%d',JYSJ) ORDER BY strftime('%m-%d',JYSJ) desc limit 7;
  -- 日期
    select strftime('%m-%d',JYSJ) from bill group by strftime('%m-%d',JYSJ) ORDER BY strftime('%m-%d',JYSJ) desc limit 7;
  -- 金额
    select sum(JE) from bill group by strftime('%m-%d',JYSJ) ORDER BY strftime('%m-%d',JYSJ) desc limit 7;

-- 两周高低消费对比
  -- 总数据
  select strftime('%Y-%m-%d',JYSJ), strftime('%W',JYSJ), SUM(JE)from bill GROUP by strftime('%m-%d',JYSJ);


  --select count(distinct strftime('%Y-%m-%d',JYSJ)) from bill GROUP by strftime('%W',JYSJ);

  --select count(distinct strftime('%Y-%m-%d',JYSJ)) from bill GROUP by strftime('%W',JYSJ);

  --select ((select count(distinct strftime('%Y-%m-%d',JYSJ)) from bill GROUP by strftime('%W',JYSJ)) >= 3);

  -- 最高消费周
  select count(distinct strftime('%Y-%m-%d',JYSJ)), strftime('%W',JYSJ), SUM(JE) from bill GROUP by strftime('%W',JYSJ) ORDER BY SUM(JE) desc limit 1;

  -- 最低消费周
  select count(distinct strftime('%Y-%m-%d',JYSJ)), strftime('%W',JYSJ), SUM(JE) from bill GROUP by strftime('%W',JYSJ) ORDER BY SUM(JE);


  select count(distinct strftime('%W',JYSJ)),strftime('%W',JYSJ)  from bill GROUP by strftime('%W',JYSJ);
  select strftime('%W',JYSJ),count(distinct strftime('%W',JYSJ)),SUM(JE) from bill GROUP by strftime('%W',JYSJ);


  -- 10周 1天 50元
  select strftime('%W',JYSJ),count(distinct strftime('%W',JYSJ)),SUM(JE) from bill GROUP by strftime('%W',JYSJ) ORDER BY SUM(JE) limit 1;

   -- 每天平均消费金额
  select (
        (select SUM(JE) from bill where SZ='支出')
         /
        (select count(distinct strftime('%Y-%m-%d',JYSJ)) from bill)
        );

  -- 最低日期
  select strftime('%Y-%m-%d',JYSJ) from bill GROUP by strftime('%m-%d',JYSJ) limit 1;

  -- 最高日期
  select strftime('%Y-%m-%d',JYSJ) from bill GROUP by strftime('%m-%d',JYSJ) ORDER BY strftime('%m-%d',JYSJ) desc limit 1;


-- 交易时间 交易类型 	交易对方	商品	收/支	金额(元)	支付方式	当前状态	交易单号	商户单号	备注
-- JYSJ      JYLX        JYDF    SP    SZ    JE          ZFFS      DQZT      JYDH      SPDH      BZ


-- TOP10 消费清单
  -- 商品  金额 交易时间 当前状态  支付方式
  select SP, JE, JYSJ, DQZT, ZFFS from bill ORDER BY JE DESC limit 10;


-- 每天是否都有消费

-- 消费支收
  -- 收到红包
  select strftime('%Y-%m-%d',JYSJ), Count(strftime('%Y-%m-%d',JYSJ)) from bill
        where JYLX == '微信红包'
        group by strftime('%Y-%m-%d',JYSJ)
        ORDER BY COUNT(strftime('%Y-%m-%d',JYSJ))
        DESC LIMIT 1;

-- 半年消费分类

  -- 判断最小月 < 3月  输出 [1, 2, 3, 4, 5, 6, 7]
  -- 判断最中月 >=3月  输出 [3, 4, 5, 6, 7, 8, 9]
  -- 判断最大月 >=8月  输出 [6, 7, 8, 9 ,10, 11, 12]

  -- 获取最小月
  select strftime('%m',JYSJ) from bill
        GROUP BY strftime('%m',JYSJ)
        ORDER BY strftime('%m',JYSJ)
        limit 1;

  -- 获取所有月份
  select strftime('%m',JYSJ) from bill GROUP BY strftime('%m',JYSJ);

  -- 获取 金额 交易对方 月份
  select JE, JYDF, strftime('%m',JYSJ) from bill where NOT JYDF == '/';

  -- 美食消费多少
  select strftime('%W',JYSJ)


-- 消费最高一周收支记录

  -- 总数据

    -- 支出 + 1
    select strftime('%w',JYSJ),sum(JE)  from bill
        where
              strftime('%W',JYSJ) == (select strftime('%W',JYSJ) from bill
                                          GROUP by strftime('%W',JYSJ)
                                          ORDER BY SUM(JE) desc limit 1)
        and NOT SZ == '/' and SZ =='支出'
        GROUP BY strftime('%Y-%m-%d',JYSJ);

    -- 收入 + 1
    select strftime('%w',JYSJ),sum(JE)  from bill
        where
              strftime('%W',JYSJ) == (select strftime('%W',JYSJ) from bill
                                          GROUP by strftime('%W',JYSJ)
                                          ORDER BY SUM(JE) desc limit 1)
        and NOT SZ == '/' and SZ =='收入'
        GROUP BY strftime('%Y-%m-%d',JYSJ);


-- 全年各月收支记录
  --总数据

    -- 各月支出
    select strftime('%m',JYSJ),sum(JE)  from bill
        where
              NOT SZ == '/'
              and SZ =='支出'
        GROUP BY strftime('%m',JYSJ);

    -- 各月收入
    select strftime('%m',JYSJ),sum(JE)  from bill
        where
              NOT SZ == '/'
              and SZ =='收入'
        GROUP BY strftime('%m',JYSJ);


-- 交易时间 交易类型 	交易对方	商品	收/支	金额(元)	支付方式	当前状态	交易单号	商户单号	备注
-- JYSJ      JYLX        JYDF    SP    SZ    JE          ZFFS      DQZT      JYDH      SPDH      BZ



-- 经常消费的商铺
  select JYDF, JE from bill
        where
              not JYDF == '/'
              AND not JYDF == '转账'
        GROUP BY strtime('%Y-%m-%d', JYDF);


-- 钱都去了哪里
  select JYDF, COUNT(JYDF) from BILL where NOT JYDF == '/' group BY JYDF order by COUNT(JYDF) DESC limit 8;

  select JYDF, COUNT(JYDF) from BILL
        where
              NOT JYDF == '/'
        group BY JYDF
        order by COUNT(JYDF)
        DESC limit 8;


-- 微信账单

  -- 民以食为天,共计吃饭消费 5000元 吃饭不能省呀，也要节俭呀

    select SUM(JE) from bill
          where
                SP LIKE '%饭店%'
                or JYDF LIKE '%小吃%'
                or JYDF LIKE '%美食%'
                or SP LIKE '%面%'
                or SP LIKE '%饭%';

  -- 天呐，没想到！你竟然最爱吃的是这个：番茄炒鸡蛋

  -- 感谢您为雾霾天做出的贡献，交通出行消费500元 历史将会铭记你！

    select SUM(JE) from bill where JYDF  LIKE '%滴滴%' or SP LIKE '%地铁%' or JYDF LIKE '%北京轨道交通%' or JYDF LIKE '%车%' or JYDF LIKE '%加油%' or SP LIKE '%加油%';
    select SUM(JE) from bill
          where
                JYDF  LIKE '%滴滴%'
                or SP LIKE '%地铁%'
                or JYDF LIKE '%北京轨道交通%'
                or JYDF LIKE '%车%'
                or JYDF LIKE '%加油%'
                or SP LIKE '%加油%';



    select SUM(JE) from bill where JYDF  LIKE '%滴滴%' or SP LIKE '%地铁%' or JYDF LIKE '%北京轨道交通%' or JYDF LIKE '%摩拜%' or JYDF LIKE '%黄车%' or JYDF LIKE '%车%';


  --  共计200天, 共消费600次, 平均每天至少消费7次, 平均每次消费20元
    SELECT (select count(distinct strftime('%Y-%m-%d',JYSJ)) from bill),(select count(SP) from BILL where NOT JYDF == '/' or NOT SP == '/' or NOT SZ == '收入'), (select((select count(SP) from BILL where NOT JYDF == '/' or NOT SP == '/') / (select count(distinct strftime('%Y-%m-%d',JYSJ)) from bill))), (select(((SELECT SUM(JE) from BILL WHERE SZ == '支出' or SZ== '/') / (select count(SP) from BILL where NOT JYDF == '/' or NOT SP == '/' or NOT SZ == '收入')) / (select((select count(SP) from BILL where NOT JYDF == '/' or NOT SP == '/') / (select count(distinct strftime('%Y-%m-%d',JYSJ)) from bill)))));


    --共计多少天
      select count(distinct strftime('%Y-%m-%d',JYSJ)) from bill;

    --共消费多少次
      select count(SP) from BILL where NOT JYDF == '/' or NOT SP == '/' or NOT SZ == '收入';

    --平均每天至少消费次
      select((select count(SP) from BILL where NOT JYDF == '/' or NOT SP == '/') / (select count(distinct strftime('%Y-%m-%d',JYSJ)) from bill));

    --平均每次消费元
      select(((SELECT SUM(JE) from BILL WHERE SZ == '支出' or SZ== '/') / (select count(SP) from BILL where NOT JYDF == '/' or NOT SP == '/' or NOT SZ == '收入')) / (select((select count(SP) from BILL where NOT JYDF == '/' or NOT SP == '/') / (select count(distinct strftime('%Y-%m-%d',JYSJ)) from bill))));

    --共计消费
      SELECT SUM(JE) from BILL WHERE SZ == '支出' or SZ== '/';



  -- 起止日期2019-01-01 至 2019-03-29 其中 7 天没有消费

    select strftime('%Y-%m-%d',JYSJ) from bill where NOT JYDF == '/' and NOT SP == '/';



  -- 最高消费的一天
  select strftime('%Y-%m-%d',JYSJ) from BILL GROUP BY strftime('%Y-%m-%d',JYSJ) ORDER BY SUM(JE) DESC limit 1;


  -- 通过扫二维码付款消费 10000 元，通过商户消费 美食 元

  SELECT (SELECT SUM(JE) from BILL WHERE JYLX == '扫二维码付款'), (SELECT SUM(JE) from BILL WHERE JYLX == '商户消费');

  SELECT SUM(JE) from BILL WHERE JYLX == '扫二维码付款';

  SELECT SUM(JE) from BILL WHERE JYLX == '商户消费';


  -- 账单至少消费多少钱
  SELECT SUM(JE) FROM BILL where NOT SP == '/';


  -- 账单时间格式

    -- 起止日期
      select min(distinct strftime('%Y/%m/%d',JYSJ)) from bill;
    -- 结束日期
      select max(distinct strftime('%Y/%m/%d',JYSJ)) from bill;

  -- 合计 支出金额 收入金额 总计流水

    -- 合计
    SELECT (SELECT SUM(JE) from BILL WHERE SZ == '支出'),(SELECT SUM(JE) from BILL WHERE SZ == '收入'), (SELECT SUM(JE) from BILL);

    -- 支出金额
      SELECT SUM(JE) from BILL WHERE SZ == '支出';

    -- 收入金额
      SELECT SUM(JE) from BILL WHERE SZ == '收入';

    -- 总计流水
      SELECT SUM(JE) from BILL;

  -- 会员等级 总计流水
      SELECT SUM(JE) from BILL;

