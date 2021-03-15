
### 分组查询

``` SQL
SELECT {字段 | 聚合函数},... FROM `表` [WHERE 事前条件] GROUP BY 字段 [HAVING 事后条件];
```

**Order**

@import "./Order.csv"

#### Default

分组查询用于从组内提取信息进行显示，每组仅能显示一行，默认情况下显示组内第一条数据。

```SQL
SELECT * FROM `Order` GROUP BY user_id;
```

@import "./Order_Default.csv"

#### Count

`Count`用于统计组内某一字段不为`NULL`的元素个数。

```SQL
SELECT user_name AS 用户, COUNT(id) AS 下单数量 FROM `Order` GROUP BY user_id;
```

@import "./Order_Count.csv"

#### Order By

```SQL
SELECT user_name AS 用户, COUNT(id) AS 下单数量 FROM `Order` GROUP BY user_id ORDER BY COUNT(id) DESC;
```

@import "./Order_Count_OrderBy.csv"

#### Where

`WHERE`用于筛选出用于分组的数据。

```SQL
SELECT user_name AS 用户, COUNT(id) AS 下单数量 FROM `Order` WHERE Order.year=2018 GROUP BY user_id;
```

@import "./Order_Count_Where.csv"

#### Having

`HAVING`用于在分组后继续筛选数据。

```SQL
SELECT user_name AS 用户, COUNT(id) AS 下单数量 FROM `Order` GROUP BY user_id HAVING COUNT(id)>2;
```

@import "./Order_Count_Having.csv"

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

@import "./Order_Summary.csv"
