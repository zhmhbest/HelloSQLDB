
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
