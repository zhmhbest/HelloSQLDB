<link rel="stylesheet" href="https://zhmhbest.gitee.io/hellomathematics/style/index.css">
<script src="https://zhmhbest.gitee.io/hellomathematics/style/index.js"></script>

# [SQL](./index.html)

[TOC]

## 用户及其权限管理

### 用户管理

```SQL
# 查看用户（管理员）
# SELECT * FROM mysql.user;
SELECT User,Host,Password FROM mysql.user;

# 创建用户
# %: 任意地址的远程主机
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'username'@'addr' IDENTIFIED BY 'password';
CREATE USER 'username'@'%' IDENTIFIED BY 'password';
CREATE USER 'username'@'192.168.1.%' IDENTIFIED BY 'password';
INSERT INTO mysql.user (User,Host,Password) VALUES('username','host',PASSWORD('password'));

# 修改指定用户密码
SET PASSWORD FOR 'username'@'host' = PASSWORD('new_password');

# 修改当前用户密码
SET PASSWORD = PASSWORD('new_password');

# 删除用户
DROP USER 'username'@'host';
```

### 用户权限管理

```SQL
# 查看当前用户权限
SHOW GRANTS;

# 查看用指定户权限
SHOW GRANTS FOR 'username'@'host';

# 授予用户具体权限
GRANT 权限,... ON 库.表 TO 'username'@'host';
# 权限（增、删、改、查）= INSERT, DELETE, UPDATE, SELECT
# 权限（表结构）= CREATE, ALTER, DROP
# 权限（外键、索引）= REFERENCES, INDEX
# 权限（视图）= CREATE VIEW, SHOW VIEW
# 权限（临时表）= CREATE TEMPORARY TABLES
# 权限（存储过程、函数）= CREATE ROUTINE, ALTER ROUTINE, EXECUTE

# 授予用户一个数据库所有权限
# WITH GRANT OPTION: 用户可以将自己拥有的权限授权给别人
GRANT ALL PRIVILEGES ON 库.* TO 'username'@'host' [WITH GRANT OPTION];

# 撤销用户具体权限
REVOKE 权限,... ON 库.表 FROM 'username'@'host';

# 撤销用户所有权限
REVOKE ALL ON *.* FROM 'username'@'host';

# 远程root用户（管理员）
CREATE USER 'root'@'%' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
SELECT USER, HOST FROM `mysql`.`user`;
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 库管理

### 查看库

```SQL
# 查看数据库编码
SHOW VARIABLES LIKE 'character_%';

# 显示所有数据库
SHOW DATABASES;

# 显示数据库构造
SHOW CREATE DATABASE `库名`;
```

### 增删改

```SQL
# 创建新数据库
CREATE DATABASE 库名 CHARACTER SET utf8 COLLATE utf8_general_ci;
# utf8: 最大字符长度为3字节，遇到4字节的宽字符会插入异常
# utf8mb4: utf8的超集，用来兼容四字节的unicode
# utf8_general_ci: 查询速度快
# utf8_unicode_ci: 查询准确

# 删除数据库
DROP DATABASE 库名;

# 修改数据库设置（主要是编码）
ALTER DATABASE 库名 CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

# 选择数据库
USE 库名;
```

### 创建数据库及其管理员

```SQL
CREATE DATABASE `db_name` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'user'@'%' IDENTIFIED BY '1234';
REVOKE ALL ON *.* FROM 'user'@'%';
GRANT ALL PRIVILEGES ON `db_name`.* TO 'user'@'%' WITH GRANT OPTION;
# DROP DATABASE `db_name`;
# DROP USER 'user'@'%';
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

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
# 连接查询（JOIN）
SELECT * FROM `表名1` ['别名1']
{ INNER JOIN | LEFT JOIN | RIGHT JOIN | FULL OUTER JOIN }
`表名2` ['别名2'] ON 连接条件
[WHERE 选择条件];
```

### 分组查询

``` SQL
# 分组查询（GROUP BY、HAVING）
SELECT * FROM `表名` WHERE 条件 GROUP BY 字段 HAVING 聚合函数;
# 根据一个或多个列对结果集进行分组
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

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 存储过程及自定义函数

### 存储过程

```SQL
# 创建
DELIMITER //
CREATE
    { FUNCTION  函数名(字段 类型, ...) RETURN 返回值类型     } |
    { PROCEDURE 过程名({ IN | OUT | INOUT } 字段 类型, ...) }
BEGIN
    -- 函数内容 | 存储过程内容
    -- 此部分详见内容编程
    RETURN 值; --仅函数可使用本方法。
    -- 存储过程通过对OUT类型字段赋值返回内容。
END //
DELIMITER ;

# 调用
SELECT `函数名`(参数, ...)        #调用函数
CALL   `过程名`(参数,@变量名,...) #调用存储过程

# 销毁
# 存储过程及函数一旦创建将会一直保存在数据库中，除非手动销毁。
DROP FUNCTION  函数名; #删除函数
DROP PROCEDURE 过程名; #删除存储过程
```

### 触发器

```SQL
# 查看
SELECT * FROM  INFORMATION_SCHEMA.TRIGGERS;
SHOW TRIGGERS;
SHOW CREATE TRIGGER;

# 创建
DELIMITER //
CREATE TRIGGER 触发器名 {BEFORE | AFTER} {INSERT | DELETE | UPDATE} ON `表名` FOR EACH ROW BEGIN
    -- 程序体
END //
DELIMITER ;

# 删除
DROP TRIGGER 触发器名;
```

### 定时器

```SQL
# 创建
CREATE EVENT IF NOT EXISTS 事件名称
ON SCHEDULE EVERY 1 SECOND
ON COMPLETION PRESERVE
ENABLE DO CALL 存储过程();

# 启用/停止
ALTER EVENT 事件名称 ON  COMPLETION PRESERVE {ENABLE | DISABLE};
```

### 内容编程

#### 变量

```SQL
# 声明
DECLARE 变量名 变量类型 [DEFAULT 值];

# 赋值
SET @hello='Hello';
SELECT @hello;
```

#### 条件语句（IF）

```SQL
IF 条件 THEN
    -- 语句1;
ELSE
    -- 语句2;
END IF ;
```

#### 条件语句（CASE）

```SQL
CASE 变量
    WHEN 值1 THEN
        -- 语句1;
    WHEN 值2 THEN
        -- 语句2;
    ELSE
        -- 语句3;
END CASE ;
```

#### 循环语句

```SQL
# WHILE
DECLARE i INT DEFAULT 5;
WHILE i>0 DO
    SET i=i-1;
END WHILE;

# REPEAT
DECLARE i INT DEFAULT 0;
REPEAT
    SET i=i+1;
UNTIL i>=5
END REPEAT;

# LOOP
DECLARE i INT DEFAULT 0;
LOOP_LABLE:LOOP
    SET i=i+1;
    IF i>=5 THEN
        LEAVE LOOP_LABLE;
    END IF;
END LOOP;
```
