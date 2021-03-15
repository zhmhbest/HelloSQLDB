### 连接查询

``` SQL
SELECT
    *
FROM
    `表1` [AS '别名1']
{ INNER JOIN | LEFT OUTER JOIN | RIGHT OUTER JOIN | FULL OUTER JOIN }
    `表2` ['别名2']
ON
    连接条件
[WHERE 选择条件];
-- Mysql不支持 FULL OUTER JOIN
```

**R**

@import "./R.csv"

**S**

@import "./S.csv"

#### 内连接

``` SQL
SELECT * FROM `R` INNER JOIN `S` ON R.B=S.B;
# SELECT * FROM `R` JOIN `S` ON R.B=S.B;
# SELECT * FROM `R`,`S` WHERE R.B=S.B
```

@import "./INNER_JOIN.csv"

#### 左外连接

``` SQL
SELECT * FROM `R` LEFT OUTER JOIN `S` ON R.B=S.B;
# SELECT * FROM `R` LEFT JOIN `S` ON R.B=S.B;
```

@import "./LEFT_JOIN.csv"

#### 右外连接

``` SQL
SELECT * FROM `R` RIGHT OUTER JOIN `S` ON R.B=S.B;
# SELECT * FROM `R` RIGHT JOIN `S` ON R.B=S.B;
```

@import "./RIGHT_JOIN.csv"

#### 完全外连接

``` SQL
SELECT * FROM `R` LEFT OUTER JOIN `S` ON R.B=S.B
UNION
SELECT * FROM `R` RIGHT OUTER JOIN `S` ON R.B=S.B;
```

@import "./FULL_JOIN.csv"
