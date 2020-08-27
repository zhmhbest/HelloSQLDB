<link rel="stylesheet" href="https://zhmhbest.gitee.io/hellomathematics/style/index.css">
<script src="https://zhmhbest.gitee.io/hellomathematics/style/index.js"></script>

# [SQL](./index.html)

[TOC]

## 表管理

### 查看表

```SQL
# 查看表结构
SHOW CREATE TABLE 表名;

# 查看表信息
DESC TABLE 表名;
```

### 表操作

```SQL
# 创建新表
CREATE TABLE 表名 (
    字段1 类型1 [约束1] [COMMENT '注解1'],
    字段2 类型2 [约束2] [COMMENT '注解2'],
    ...
    [ , PRIMARY KEY(字段) ]
    [ , ADD FOREIGN KEY (字段) REFERENCES `表名`(字段) ]
);
# 约束 = NOT NULL | UNIQUE | CHECK (条件) | DEFAULT 值 | AUTO_INCREMENT[=起始值]
# 添加主键: PRIMARY KEY (字段)
# 添加外键: ADD FOREIGN KEY (字段) REFERENCES `表名`(字段)

# 根据已存在的表创建表
CREATE TABLE `表1`(SELECT * FROM `表2`);

# 重命名表
RENAME TABLE `旧表名` TO `新表名`;

# 删除表
DROP TABLE `表名`;
```

### 字段操作

```SQL
# 添加字段
ALTER TABLE `表名` ADD (字段 类型 [约束] [COMMENT '注解'], ...);

# 修改字段名和类型
ALTER TABLE `表名` CHANGE COLUMN 旧字段 新字段 新类型;

# 修改字段类型
ALTER TABLE `表名` MODIFY 字段 新类型;

# 删除字段
ALTER TABLE `表名` DROP 字段;
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

<!--
## 索引与视图

### 索引

```SQL
# 创建索引
CREATE INDEX 索引名称 ON `表名` (字段, ...);

# 查看索引
SHOW INDEX FROM `表名`;

# 删除索引
DROP INDEX [索引名称] ON `表名`;
```

### 视图

```SQL
# 创建视图
CREATE VIEW 视图名称 AS SELECT [字段, ...] FROM `表名`, ... [WHERE 条件];

# 删除视图
DROP VIEW [IF EXISTS] 视图名称;
```
 -->

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 数据增删改

### 增加

```SQL
# 为指定的字段赋值1
INSERT INTO `表名` (字段,...) VALUES(值, ...);

# 为指定的字段赋值2
INSERT INTO `表名` SET 字段=值,...;

# 为一行的所有数据赋值
# 该方法需要为表中一行所有字段按序赋
INSERT INTO `表名` VALUES(值, ...);

# 从已有数据增加
INSERT INTO `表名1` SELECT 字段 FROM `表名2`;
```

### 更新

```SQL
# 全表更新
UPDATE `表名` SET 字段=参数,...;

# 简单条件更新
# 基础运算符: + - * / %
# 逻辑运算符: = > < <> >= <= NOT AND OR
UPDATE `表名` SET `字段`=参数,... WHERE 条件;
```

### 删除

```SQL
# 删除一行数据
DELETE FROM `表名` WHERE 条件;

# 清空表内所有数据
TRUNCATE TABLE `表名`;
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 查找

### 简单查找

```SQL
# 显示所有字段
SELECT * FROM 表名 [WHERE 条件];

# 显示具体字段
SELECT 字段 AS '别名'[, 字段2 AS '别名2', ...] FROM 表名 [WHERE 条件];
SELECT 字段    '别名'[, 字段2 AS '别名2', ...] FROM 表名 [WHERE 条件];

# 结果排序
# ASC : 顺序，自上至下升序（默认）
# DESC: 逆序，自上至下降序
SELECT * FROM 表名 ORDER BY 字段1 [ASC|DESC] [, 字段2 [ASC|DESC]];
# 当字段1的值一样时，就会根据字段2排序。

# 去除结果重复值（DISTINCT）
SELECT DISTINCT 字段 FROM `表名`;

# 规定要返回的记录的数目
SELECT 字段 FROM `表名` LIMIT 数量;   # MySQL
SELECT 字段 FROM `表名` ROWNUM<=数量; # Oracle
```

### 高级查找

```SQL
# 连续查询
SELECT * FROM `表名` WHERE 字段1 IN (SELECT 字段1 FROM `表名` WHERE 条件);

# 字符串模糊查找
# %     : 最少0个的任意多个字符
# _     : 1个任意字符
# [abc] : 匹配a、b、c中的任意一个字符
# [^abc]: 匹配只要不是a、b、c中一个的任意字符
# [!abc]: 同[^abc]
SELECT * FROM `表名` WHERE 字段 LIKE '%oo%';
# 选出字段中包含'oo'（两侧或中间均可）的行

# 多值查询（IN）
SELECT * FROM `表名` WHERE 字段 IN (值1,值2, ...);
# 以上代码相当于如下代码
SELECT * FROM `表名` WHERE 字段=值1 OR 字段=值2 OR ...;

# 值间查询（BETWEEN）
SELECT * FROM `表名` WHERE 字段 BETWEEN 值1 AND 值2;
# 以上代码相当于如下代码
# 其中值可以是：15、'A'、'2016-05-10'，这种数据。
SELECT * FROM `表名` WHERE 字段>=值1 AND 字段<=值2;

# 联合查询（UNION）
# 合并两个或多个SELECT语句的结果集
# 每个结果集必须拥有相同数量的列、列数据类型、列顺序。
SELECT 字段 FROM `表名1`
UNION
SELECT 字段 FROM `表名2`;
# 以上代码将自动去除重复的行

# 联合查询（UNION ALL）
SELECT 字段 FROM `表名1`
UNION ALL
SELECT 字段 FROM `表名2`;
# 以上代码将保留重复的行
```

### 连接查询

``` SQL
SELECT * FROM `表名1` ['别名1']
{ INNER JOIN | LEFT OUTER JOIN | RIGHT OUTER JOIN | FULL OUTER JOIN }
`表名2` ['别名2'] ON 连接条件
[WHERE 选择条件];
# Mysql不支持 FULL OUTER JOIN
```

**R**

@import "./data/R.csv"

**S**

@import "./data/S.csv"

#### 内连接

``` SQL
SELECT * FROM `R` INNER JOIN `S` ON R.B=S.B;
# SELECT * FROM `R` JOIN `S` ON R.B=S.B;
```

@import "./data/INNER_JOIN.csv"

#### 左外连接

``` SQL
SELECT * FROM `R` LEFT OUTER JOIN `S` ON R.B=S.B;
# SELECT * FROM `R` LEFT JOIN `S` ON R.B=S.B;
```

@import "./data/LEFT_JOIN.csv"

#### 右外连接

``` SQL
SELECT * FROM `R` RIGHT OUTER JOIN `S` ON R.B=S.B;
# SELECT * FROM `R` RIGHT JOIN `S` ON R.B=S.B;
```

@import "./data/RIGHT_JOIN.csv"

#### 完全外连接

``` SQL
SELECT * FROM `R` LEFT OUTER JOIN `S` ON R.B=S.B
UNION
SELECT * FROM `R` RIGHT OUTER JOIN `S` ON R.B=S.B;
```

@import "./data/FULL_JOIN.csv"

### 分组查询

``` SQL
SELECT {字段 | 聚合函数},... FROM `表名` [WHERE 条件] GROUP BY 字段 [HAVING 聚合函数];
```

**Order**

@import "./data/Order.csv"

#### Count

```SQL
# 将相同user_id的数据归为一组，统计每组有几条含有字段id的元组。
SELECT user_name AS 用户, COUNT(id) AS 下单数量 FROM `Order` GROUP BY user_id;
```

@import "./data/Order_Count.csv"

#### Order By

```SQL
SELECT user_name AS 用户, COUNT(id) AS 下单数量 FROM `Order` GROUP BY user_id ORDER BY COUNT(id) DESC;
```

@import "./data/Order_Count_OrderBy.csv"

#### Where

`WHERE`用于筛选出用于分组的数据。

```SQL
SELECT user_name AS 用户, COUNT(id) AS 下单数量 FROM `Order` WHERE Order.year=2018 GROUP BY user_id;
```

@import "./data/Order_Count_Where.csv"

#### Having

`HAVING`用于在分组后继续筛选数据。

```SQL
SELECT user_name AS 用户, COUNT(id) AS 下单数量 FROM `Order` GROUP BY user_id HAVING COUNT(id)>2;
```

@import "./data/Order_Count_Having.csv"

#### 小结

```SQL
SELECT
    user_name AS 用户,
    COUNT(id) AS 消费次数,
    MAX(price) AS 最大消费,
    MIN(price) AS 最低消费,
    SUM(price) AS 总消费,
    AVG(price) AS 平均消费
FROM `Order` GROUP BY user_id;
```

@import "./data/Order_Summary.csv"

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 事务

### 隔离级别

```SQL
# 查看隔离级别
SELECT @@tx_isolation;

# 设置隔离级别
SET [GLOBAL] TRANSACTION ISOLATION LEVEL
{ READ UNCOMMITTED | READ COMMITTED | REPEATABLE READ | SERIALIZABLE };
# 读取未提交内容 | 读取提交内容 | 可重复读 | 可串行化
```

### 运行事务

```SQL
# 启动
START TRANSACTION;

# 回滚
ROLLBACK;

# 提交
COMMIT;
```
