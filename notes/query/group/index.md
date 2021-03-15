
### 分组查询

``` SQL
SELECT
    {字段 | 聚合函数}, ...
FROM
    `表`
[WHERE 筛选分组时使用的数据]
GROUP BY
    字段
[HAVING 筛选分组];
```

`tbl_order`

@import "./tbl_order.sql"

@import "./tbl_order.csv"

#### Default

分组查询用于从组内提取信息进行显示，每组仅能显示一行，默认情况下显示组内第一条数据。

```SQL
SELECT * FROM tbl_salary GROUP BY `id`;
```

@import "./result_default.csv"

#### Count

`Count`用于统计组内某一字段不为`NULL`的元素个数。

```SQL
SELECT name, COUNT(id) AS count FROM tbl_salary GROUP BY `id`;
```

@import "./result_count.csv"

#### Order By

```SQL
SELECT name, COUNT(id) AS count FROM tbl_salary GROUP BY `id` ORDER BY count DESC;
```

@import "./result_count_order.csv"

#### Where

`WHERE`用于筛选出用于分组的数据。

```SQL
SELECT name, COUNT(id) AS count FROM tbl_salary WHERE monthId>='201907' GROUP BY `id`;
```

@import "./result_count_where.csv"

#### Having

`HAVING`用于在分组后继续筛选数据。

```SQL
SELECT name, COUNT(id) AS count FROM tbl_salary GROUP BY `id` HAVING count>2;
```

@import "./result_ount_having.csv"

#### 行转列

```SQL
-- 静态
SELECT
    `id`,
    `name`,
    MAX(CASE monthId WHEN '201906' THEN salary ELSE 0 END) AS '201906',
    MAX(CASE monthId WHEN '201907' THEN salary ELSE 0 END) AS '201907',
    MAX(CASE monthId WHEN '201908' THEN salary ELSE 0 END) AS '201908',
    MAX(CASE monthId WHEN '201909' THEN salary ELSE 0 END) AS '201909'
FROM
    `tbl_salary`
GROUP BY
    `id`;
```

@import "./result_row_col.csv"
