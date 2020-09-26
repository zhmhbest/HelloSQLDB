<link rel="stylesheet" href="https://zhmhbest.gitee.io/hellomathematics/style/index.css">
<script src="https://zhmhbest.gitee.io/hellomathematics/style/index.js"></script>

# [SQL Common](./index.html)

[TOC]

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
# 删除行数据
DELETE FROM `表名` WHERE 条件;

# 清空表内所有数据
TRUNCATE TABLE `表名`;
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 查找

```SQL
# 显示所有字段
SELECT
    [DISTINCT]
    字段 [AS '别名'], ...
FROM
    {`表1` | (SELECT ...) AS '结果别名'}
    , ...
[WHERE 条件]
[ORDER BY 排序参考的字段1 [ASC | DESC], ...]
[LIMIT 返回行数 [OFFSET 偏移量] | LIMIT 偏移量,返回行数]
;

# DISTINCT: 去除重复
# ASC : 顺序，自上至下升序（默认）
# DESC: 逆序，自上至下降序
```

### 条件筛选

#### 简单筛选

```SQL
SELECT * FROM `表` WHERE 字段 IS NULL;
SELECT * FROM `表` WHERE 字段 IS NOT NULL;

# > < = != <= >=
SELECT * FROM `表` WHERE 字段=值;
SELECT * FROM `表` WHERE 字段=(SELECT MIN(字段) FROM `表`);
SELECT * FROM `表` WHERE 字段=(SELECT MAX(字段) FROM `表`);
SELECT * FROM `表` WHERE 字段>(SELECT AVG(字段) FROM `表`);
```

#### 多值筛选

```SQL
SELECT * FROM `表` WHERE 字段 IN (值1,值2, ...);
SELECT * FROM `表` WHERE 字段 NOT IN (值1,值2, ...);

SELECT * FROM `表` WHERE 字段=值1 OR 字段=值2 OR ...;
SELECT * FROM `表` WHERE 字段!=值1 AND 字段!=值2 AND ...;

SELECT * FROM `表` WHERE 字段 IN (SELECT ...);
SELECT * FROM `表` WHERE 字段 NOT IN (SELECT ...);
```

#### 值间筛选

```SQL
SELECT * FROM `表` WHERE 字段 BETWEEN 值1 AND 值2;
SELECT * FROM `表` WHERE 字段>=值1 AND 字段<=值2;
# 其中值可以是：数字、字母、日期、时间等数据。
```

#### 字符串模糊筛选

```SQL
# %     : 最少0个的任意多个字符
# _     : 1个任意字符
# [abc] : 匹配a、b、c中的任意一个字符
# [^abc]: 匹配只要不是a、b、c中一个的任意字符
# [!abc]: 同[^abc]
SELECT * FROM `表` WHERE 字段 LIKE '%oo%';
# 选出字段中包含'oo'（两侧或中间均可）的行
```

### 联合查询

合并两个或多个SELECT语句的结果集，每个结果集必须拥有**相同数量的列、列数据类型、列顺序**。

```SQL
SELECT 字段, ... FROM `表1`
UNION
SELECT 字段, ... FROM `表2`;
# 以上代码将自动去除重复的行

SELECT 字段, ... FROM `表1`
UNION ALL
SELECT 字段, ... FROM `表2`;
# 以上代码将保留重复的行
```

### 连接查询

``` SQL
SELECT * FROM `表1` [AS '别名1']
{ INNER JOIN | LEFT OUTER JOIN | RIGHT OUTER JOIN | FULL OUTER JOIN }
`表2` ['别名2'] ON 连接条件
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
# SELECT * FROM `R`,`S` WHERE R.B=S.B
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
SELECT {字段 | 聚合函数},... FROM `表` [WHERE 条件] GROUP BY 字段 [HAVING 聚合函数];
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

### Empty和Null

**Empty**

```SQL
SELECT id FROM `Order` WHERE id=-1;
```

```txt
MariaDB [test_sql]> SELECT id FROM `Order` WHERE id=-1;
Empty set (0.00 sec)
```

**Null**

```SQL
SELECT IFNULL((SELECT id FROM `Order` WHERE id=-1), NULL) AS id;
# SELECT (SELECT id FROM `Order` WHERE id=-1) AS id;
```

```txt
MariaDB [test_sql]> SELECT IFNULL((SELECT id FROM `Order` WHERE id=-1), NULL) AS id;
+------+
| id   |
+------+
| NULL |
+------+
1 row in set (0.00 sec)
```

如果使用Navicat Premium等软件可能导致忽视此问题的存在。

### 应用

**SC**

@import "data/SC.sql"

#### 格式化学生成绩

```SQL
SELECT
    `name` AS '姓名',
    MAX(IF(`course` = '政治', ROUND(`score`, 2), NULL)) AS '政治',
    MAX(IF(`course` = '历史', ROUND(`score`, 2), NULL)) AS '历史',
    MAX(IF(`course` = '地理', ROUND(`score`, 2), NULL)) AS '地理',
    MAX(IF(`course` = '生物', ROUND(`score`, 2), NULL)) AS '生物',
    MAX(IF(`course` = '语文', ROUND(`score`, 2), NULL)) AS '语文',
    MAX(IF(`course` = '数学', ROUND(`score`, 2), NULL)) AS '数学',
    MAX(IF(`course` = '外语', ROUND(`score`, 2), NULL)) AS '外语',
    MAX(IF(`course` = '物理', ROUND(`score`, 2), NULL)) AS '物理',
    MAX(IF(`course` = '化学', ROUND(`score`, 2), NULL)) AS '化学'
FROM
    `SC`
GROUP BY
    `name`
;
```

@import "data/SC_FORMAT.csv"

#### 统计各科分数大于85分的人数和人数占比

>使用`SC`表

```SQL
SELECT
    `course` AS '课程',
    COUNT(IF(`score`>85, TRUE, NULL)) AS '满足人数',
    COUNT(`score`) AS '总人数',
    CONCAT(ROUND(COUNT(IF(`score`>85, TRUE, NULL)) / COUNT(`score`) * 100, 2), '%')  AS '占比'
FROM
    `SC`
GROUP BY
    `course`
;
```

@import "data/SC_STATISTICS1.csv"

#### 统计各分段的人数

```SQL
SELECT
    `course` AS '课程',
    SUM(CASE WHEN `score` BETWEEN 85 AND 100 THEN 1 ELSE 0 END) AS '优秀人数',
    SUM(CASE WHEN `score` BETWEEN 60 AND 84 THEN 1 ELSE 0 END) AS '及格人数',
    SUM(CASE WHEN `score`<60 THEN 1 ELSE 0 END) AS '不及格人数'
FROM
    `SC`
GROUP BY
    `course`
;
```

@import "data/SC_STATISTICS2.csv"

#### 按平均成绩进行排名，并添加一列显示名次

>使用`SC`表

- ***Step1*：显示平均成绩**

```SQL
DROP VIEW IF EXISTS `SC_AVG`;
CREATE VIEW `SC_AVG` AS (
    SELECT
        `name`,
        ROUND(AVG(`score`), 2) AS 'score'
    FROM
        `SC`
    GROUP BY
        `name`
);
SELECT * FROM `SC_AVG`;
```

@import "data/SC_RANK_STEP1.csv"

- ***Step2*：连接并表**

```SQL
DROP VIEW IF EXISTS `SC_JOIN`;
CREATE VIEW `SC_JOIN` AS (
    SELECT
        `A`.`name`  AS 'nameA',
        `A`.`score` AS 'scoreA',
        `B`.`name`  AS 'nameB',
        `B`.`score` AS 'scoreB'
    FROM
        `SC_AVG` AS `A`,
        `SC_AVG` AS `B`
    WHERE
        `A`.`score` <= `B`.`score`
);
SELECT * FROM `SC_JOIN`;
```

@import "data/SC_RANK_STEP2.csv"

- ***Step3*：统计排名**

```SQL
SELECT
    `nameA` AS '姓名',
    `scoreA` AS '平均分',
    COUNT(DISTINCT(`scoreB`)) AS '排名'
FROM
    `SC_JOIN`
GROUP BY
    `nameA`
ORDER BY
    `scoreA` DESC
;

DROP VIEW IF EXISTS `SC_AVG`;
DROP VIEW IF EXISTS `SC_JOIN`;
```

@import "data/SC_RANK_STEP3.csv"

- ***Step4*：小结**

```SQL
SELECT
    `A`.`name` AS '姓名',
    `A`.`score` AS '平均分',
    COUNT(DISTINCT(`B`.`score`)) AS '排名'
FROM
    ( SELECT `name`, AVG(`score`) AS 'score' FROM `SC` GROUP BY `name` ) AS `A`,
    ( SELECT `name`, AVG(`score`) AS 'score' FROM `SC` GROUP BY `name` ) AS `B`
WHERE
    `A`.`score` <= `B`.`score`
GROUP BY
    `A`.`name`
ORDER BY
    `A`.`score` DESC
;
```

- **补充：Python生成排名模板**

```py
def get_sql_rank(
        to_be_sorted_view: str,
        to_be_sorted_field: str,
        to_be_classified_field: str,
        to_be_sorted_name='得分',
        to_be_classified_name='类别',
        rank_name='排名',
        part_name_l='A',
        part_name_r='B',
        how_to_order='DESC'
):
    """
    生成排序模板
    :param to_be_sorted_view: 待排序视图
    :param to_be_sorted_field: 待排序字段
    :param to_be_classified_field: 待分类字段
    :param to_be_sorted_name:
    :param to_be_classified_name:
    :param rank_name:
    :param part_name_l: 左表临时名
    :param part_name_r: 右表临时名
    :param how_to_order: DESC:第一名在最前 | ASC:第一名在最后
    :return: sql
    """
    to_be_sorted_view = to_be_sorted_view.strip()
    if '(' == to_be_sorted_view[0] and ')' == to_be_sorted_view[-1]:
        to_be_sorted_view = ' '.join([line.strip() for line in to_be_sorted_view.split('\n')])
    else:
        to_be_sorted_view = f"`{to_be_sorted_view}`"

    sql_template = f"""
    SELECT
        `{part_name_l}`.`{to_be_classified_field}` AS {to_be_classified_name},
        `{part_name_l}`.`{to_be_sorted_field}` AS {to_be_sorted_name},
        COUNT(DISTINCT(`{part_name_r}`.`{to_be_sorted_field}`)) AS {rank_name}
    FROM
        {to_be_sorted_view} AS `{part_name_l}`,
        {to_be_sorted_view} AS `{part_name_r}`
    WHERE
        `{part_name_l}`.`{to_be_sorted_field}` <= `{part_name_r}`.`{to_be_sorted_field}`
    GROUP BY
        `{part_name_l}`.`{to_be_classified_field}`
    ORDER BY
        `{part_name_l}`.`{to_be_sorted_field}` {how_to_order}
    ;
    """
    return sql_template


if __name__ == '__main__':
    sql = get_sql_rank('''
    (
        SELECT
            `name`,
            AVG(`score`) AS 'score'
        FROM
            `SC`
        GROUP BY
            `name`
    )
    ''', 'score', 'name')
    print(sql)
```

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
