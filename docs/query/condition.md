
### 条件筛选

#### 简单筛选

```SQL
SELECT * FROM `表` WHERE 字段 IS NULL;
SELECT * FROM `表` WHERE 字段 IS NOT NULL;

# > < = != <= >=
SELECT * FROM `表` WHERE 字段=值;
```

#### 子查询筛选

```SQL
# 子查询仅返回一个值
SELECT * FROM `表` WHERE 字段=(SELECT MIN(字段) FROM `表`);
SELECT * FROM `表` WHERE 字段=(SELECT MAX(字段) FROM `表`);
SELECT * FROM `表` WHERE 字段>(SELECT AVG(字段) FROM `表`);

# 子查询返回多个值: ANY/SOME 满足一个即可
SELECT * FROM `表` WHERE 字段 > ANY (SELECT 字段 FROM `表`)
SELECT * FROM `表` WHERE 字段 > SOME (SELECT 字段 FROM `表`)

# 子查询返回多个值: ALL 需要全部满足
SELECT * FROM `表` WHERE 字段 > ALL (SELECT 字段 FROM `表`)

# 子查询返回多个值: EXISTS 子查询结果是否为Empty，Empty返回0，否则返回1
SELECT * FROM `表` WHERE EXISTS (SELECT 字段 FROM `表` WHERE 条件)
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
