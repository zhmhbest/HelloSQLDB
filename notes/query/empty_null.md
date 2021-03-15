
### Empty和Null

**Empty**

```SQL
SELECT id FROM `Order` WHERE id=-1;
```

```txt
MariaDB [...]> SELECT id FROM `Order` WHERE id=-1;
Empty set (0.00 sec)
```

**Null**

```SQL
SELECT IFNULL((SELECT id FROM `Order` WHERE id=-1), NULL) AS id;
# SELECT (SELECT id FROM `Order` WHERE id=-1) AS id;
```

```txt
MariaDB [...]> SELECT IFNULL((SELECT id FROM `Order` WHERE id=-1), NULL) AS id;
+------+
| id   |
+------+
| NULL |
+------+
1 row in set (0.00 sec)
```

如果使用Navicat Premium等软件可能导致忽视此问题的存在。
