
### Empty和Null

`empty_null`

|**id**|
|-|
|0|

#### Empty

```SQL
SELECT id FROM empty_null WHERE id=-1;
```

```txt
MariaDB [...]> ...
Empty set (0.00 sec)
```

#### Null

```SQL
SELECT IFNULL((SELECT id FROM empty_null WHERE id=-1), NULL) AS id;
-- Or
SELECT (SELECT id FROM empty_null WHERE id=-1) AS id;
```

```txt
MariaDB [...]> ...
+------+
| id   |
+------+
| NULL |
+------+
1 row in set (0.00 sec)
```

如果使用Navicat Premium等软件可能导致忽视此问题的存在。
