---
title: mysql查询今天、昨天、上周
date: 2022-07-21 15:04:00
permalink: /pages/2e1e44/
sidebar: auto
categories:
  - 随笔
tags:
  - 
---
# mysql查询今天、昨天、上周



今天 

```mysql
select * from 表名 where to_days(时间字段名) = to_days(now()); 
```

昨天

```mysql
SELECT * FROM 表名 WHERE TO_DAYS( NOW( ) ) - TO_DAYS( 时间字段名) <= 1 
```

7天 

```mysql
SELECT * FROM 表名 where DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= date(时间字段名)
```

近30天 
```mysql
SELECT * FROM 表名 where DATE_SUB(CURDATE(), INTERVAL 30 DAY) <= date(时间字段名) 
```

本月 

```mysql
SELECT * FROM 表名 WHERE DATE_FORMAT( 时间字段名, '%Y%m' ) = DATE_FORMAT( CURDATE( ) , '%Y%m' ) 
```

上一月 
```mysql
SELECT * FROM 表名 WHERE PERIOD_DIFF( date_format( now( ) , '%Y%m' ) , date_format( 时间字段名, '%Y%m' ) ) =1 
```

查询本季度数据

```mysql
select * from `ht_invoice_information` where QUARTER(create_date)=QUARTER(now()); 
```

查询上季度数据 

```mysql
select * from `ht_invoice_information` where QUARTER(create_date)=QUARTER(DATE_SUB(now(),interval 1 QUARTER)); 
```

查询本年数据 

```mysql
select * from `ht_invoice_information` where YEAR(create_date)=YEAR(NOW()); 
```

查询上年数据 

```mysql
select * from `ht_invoice_information` where year(create_date)=year(date_sub(now(),interval 1 year)); 
```

查询当前这周的数据  

```mysql
SELECT name,submittime FROM enterprise WHERE YEARWEEK(date_format(submittime,'%Y-%m-%d')) = YEARWEEK(now()); 
```

查询上周的数据 

```mysql
SELECT name,submittime FROM enterprise WHERE YEARWEEK(date_format(submittime,'%Y-%m-%d')) = YEARWEEK(now())-1; 
```
查询当前月份的数据 

```mysql
select name,submittime from enterprise  where date_format(submittime,'%Y-%m')=date_format(now(),'%Y-%m') 
```

查询距离当前现在6个月的数据 

```mysql
select name,submittime from enterprise where submittime between date_sub(now(),interval 6 month) and now(); 
```



**补充**

- 将时间戳转换为日期

​		from_unixtime(time_stamp)



- 将日期转换为时间戳

  unix_timestamp(date) 