# [SQL Database](https://zhmhbest.github.io/HelloSQLDB/README)

>[理论知识](./chapter/Theory)

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 下载

- [MySQL](https://dev.mysql.com/downloads/mysql/)
- [MariaDB](https://downloads.mariadb.org/mariadb/)
- [Sqliteman](http://sqliteman.yarpen.cz/)
- [HeidiSQL](https://www.heidisql.com/download.php)
- [NavicatPremium](./packages/Navicat_Premium_11.2.7.7z)

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 安装

### Windows

>[mariadb-10.1.38-winx64.zip](https://downloads.mariadb.org/mariadb/10.1.38/)

#### *install.bat*

```batch
@SET DB_LOCAL_HOME=D:\ProgramFiles\MariaDB\mariadb-10.1.38-winx64
@SET DB_SERVICE_NAME=mariadb
@REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
@ECHO OFF
REM 检查环境
IF NOT EXIST "%DB_LOCAL_HOME%\bin\mysqld.exe" (
    ECHO DB_LOCAL_HOME is not a database installation directory.
    PAUSE>NUL
    EXIT
)
REM 配置环境变量
SET PATH=%DB_LOCAL_HOME%\bin;%PATH%
CD /D "%DB_LOCAL_HOME%"
REM 创建配置文件
IF NOT EXIST .\my.ini (
    ECHO [client]>.\my.ini
    ECHO port=3306>>.\my.ini
    ECHO socket=/tmp/mysql.sock>>.\my.ini
    ECHO default-character-set=utf8mb4>>.\my.ini
    @REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    ECHO [mysqld]>>.\my.ini
    ECHO port=3306>>.\my.ini
    ECHO socket=/tmp/mysql.sock>>.\my.ini
    ECHO #basedir=>>.\my.ini
    ECHO #datadir=>>.\my.ini
    ECHO character_set_server=utf8mb4>>.\my.ini
    ECHO character_set_client=utf8mb4>>.\my.ini

    ECHO skip-external-locking>>.\my.ini
    ECHO key_buffer_size         = 16M>>.\my.ini
    ECHO max_allowed_packet      = 1M>>.\my.ini
    ECHO table_open_cache        = 64>>.\my.ini
    ECHO sort_buffer_size        = 512K>>.\my.ini
    ECHO net_buffer_length       = 8K>>.\my.ini
    ECHO read_buffer_size        = 256K>>.\my.ini
    ECHO read_rnd_buffer_size    = 512K>>.\my.ini
    ECHO myisam_sort_buffer_size = 8M>>.\my.ini

    ECHO log-bin=mysql-bin>>.\my.ini
    ECHO binlog_format=mixed>>.\my.ini
    ECHO server-id=1 >>.\my.ini
    @REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    ECHO [mysqldump]>>.\my.ini
    ECHO character_set_client=utf8mb4>>.\my.ini
    ECHO quick>>.\my.ini
    ECHO max_allowed_packet=16M>>.\my.ini
    @REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    ECHO [mysql]>>.\my.ini
    ECHO default-character-set=utf8mb4>>.\my.ini
    ECHO no-auto-rehash>>.\my.ini
    ECHO #safe-updates>>.\my.ini
    @REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    ECHO [myisamchk]>>.\my.ini
    ECHO key_buffer_size  = 20M>>.\my.ini
    ECHO sort_buffer_size = 20M>>.\my.ini
    ECHO read_buffer      = 2M>>.\my.ini
    ECHO write_buffer     = 2M>>.\my.ini
    @REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    ECHO [mysqlhotcopy]>>.\my.ini
    ECHO interactive-timeout>>.\my.ini
)
REM （管理员）删除旧服务
sc delete %DB_SERVICE_NAME%>nul
REM （管理员）安装服务
mysqld --install %DB_SERVICE_NAME% --defaults-file="%CD%\my.ini"
REM （管理员）启动服务
net start %DB_SERVICE_NAME%
REM 登录用户
mysql -uroot
@REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
ECHO Everything is OK.
PAUSE>NUL
```

#### *uninstall.bat*

```batch
@SET DB_SERVICE_NAME=mariadb
@REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
@ECHO OFF
net stop %DB_SERVICE_NAME%
sc delete %DB_SERVICE_NAME%
@REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
ECHO Everything is OK.
PAUSE>NUL
```

### CentOS

```bash
yum -y install mariadb mariadb-server;
sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp;
sudo firewall-cmd --reload;

# 配置向导
mysql_secure_installation

# 初始化帐号
mysqladmin -u用户名 -p[密码]

# 登录管理
mysql -u用户名 -p[密码]
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 备份及恢复

```bash
# 备份
mysqldump -u用户名 -p 数据库名 > 备份文件.sql

# 恢复（登录后）
mysql>source 备份文件.sql;
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 用户及其权限管理

### 用户管理

```SQL
# 查看用户
SELECT `User`,`Host`,`Password` FROM mysql.user;

# 创建用户
CREATE USER 'username'@'host' IDENTIFIED BY 'password';
CREATE USER 'username'@'%' IDENTIFIED BY 'password';

# 修改指定用户密码
SET PASSWORD FOR 'username'@'host' = PASSWORD('new_password');

# 修改当前用户密码
SET PASSWORD = PASSWORD('new_password');

# 删除用户
DROP USER 'username'@'host';
```

### 用户权限管理

```SQL
# 查看用户权限
SHOW GRANTS FOR 'username'@'host';

# 授予用户具体权限
GRANT 权限,... ON 库.表 TO 'username'@'host';

# 授予用户一个数据库所有权限
# GRANT 允许该用户继续创建并将权限给予子用户
GRANT ALL PRIVILEGES ON 库.* TO 'username'@'host' [WITH GRANT OPTION];

# 撤销用户具体权限
REVOKE 权限,... ON 库.表 FROM 'username'@'host';

# 撤销用户所有权限
REVOKE ALL ON *.* FROM 'username'@'localhost';
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 库管理

### 查看

```SQL
# 查看数据库编码
SHOW VARIABLES LIKE 'character_%';

# 显示所有数据库
SHOW DATABASES;

# 显示数据库构造
SHOW CREATE DATABASE 库名;
```

### 增删改

```SQL
# 创建新数据库
# CREATE DATABASE 库名 CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE 库名 CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

# 删除数据库
DROP DATABASE 库名;

# 修改数据库设置（主要是编码）
ALTER DATABASE 库名 CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

# 选择数据库
USE 库名;
```

### 创建数据库及其管理员

```SQL
CREATE DATABASE `flaskdb` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'flask'@'localhost' IDENTIFIED BY '1234';
REVOKE ALL ON *.* FROM 'flask'@'localhost';
GRANT ALL PRIVILEGES ON flaskdb.* TO 'flask'@'localhost' WITH GRANT OPTION;
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 表管理

### 查看

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

```SQL
# 创建视图（视图使用起来和表一样）
CREATE VIEW 视图名称 [(字段, ...)] AS SELECT FROM `表名` [WHERE 条件];

# 创建索引
CREATE INDEX 索引名称 ON `表名` (字段, ...);
# 索引使数据库应用程序可以更快地查找数据
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
#该方法需要为表中一行所有字段按序赋
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

![](images/join.png)

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
SELECT @变量名;

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
SET 变量名 = 变量值, ...;
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
