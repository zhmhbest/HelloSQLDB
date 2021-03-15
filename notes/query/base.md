
>[MySQL文档](https://dev.mysql.com/doc/)
>[MySQL5.7聚合函数](https://dev.mysql.com/doc/refman/5.7/en/functions.html)

```SQL
# 显示所有字段
SELECT
    [DISTINCT] 字段 [AS '别名'] | 聚合函数()
    , ...
FROM
    `表1` | (SELECT ...) [AS '结果别名']
    , ...
[WHERE 条件]
[ORDER BY 排序参考的字段1 [ASC | DESC], ...]
[LIMIT 返回行数 [OFFSET 偏移量] | LIMIT 偏移量,返回行数]
;

# DISTINCT: 去除重复
# ASC : 顺序，自上至下升序（默认）
# DESC: 逆序，自上至下降序
```
