<link rel="stylesheet" href="https://zhmhbest.gitee.io/hellomathematics/style/index.css">
<script src="https://zhmhbest.gitee.io/hellomathematics/style/index.js"></script>

# [数据库维护](./index.html)

[TOC]

## 软件

### 数据库系统

- [MySQL](https://dev.mysql.com/downloads/mysql/)
- [MariaDB](https://downloads.mariadb.org/mariadb/)
- [SQL Server](https://www.microsoft.com/zh-cn/sql-server/sql-server-downloads)

### 数据库管理工具

- [Sqliteman](http://sqliteman.yarpen.cz/)
- [HeidiSQL](https://www.heidisql.com/download.php)
- [DBeaver](https://dbeaver.io/download/)
- [Navicat Premium](https://navicat.com.cn/products#navicat)

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 安装

### Windows

- [Download mariadb-10.1.38-winx64.zip](https://downloads.mariadb.org/mariadb/10.1.38/)
- [`mariadb-install.bat`](./src/mariadb-install.bat)
- [`mariadb-uninstall.bat`](./src/mariadb-uninstall.bat)

```batch
sc stop mariadb
sc start mariadb
```

### CentOS7

```bash
sudo yum -y install mariadb mariadb-server
sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp
sudo firewall-cmd --reload;
sudo systemctl enable mariadb
sudo systemctl start  mariadb

# 配置向导
mysql_secure_installation

# 初始化帐号
mysqladmin -u${用户名} -p[${密码}]

# 登录管理
mysql -u${用户名} -p[${密码}]
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 版本

```SQL
SELECT VERSION();
```

```txt
+-----------------+
| VERSION()       |
+-----------------+
| 10.1.38-MariaDB |
+-----------------+
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 存储引擎

### 查看提供的存储引擎

```SQL
SHOW ENGINES;
```

```txt
+--------------------+---------+---------+--------------+------+------------+
| Engine             | Support | Comment | Transactions | XA   | Savepoints |
+--------------------+---------+---------+--------------+------+------------+
| CSV                | YES     | ...     | NO           | NO   | NO         |
| InnoDB             | DEFAULT | ...     | YES          | YES  | YES        |
| MEMORY             | YES     | ...     | NO           | NO   | NO         |
| MyISAM             | YES     | ...     | NO           | NO   | NO         |
| MRG_MyISAM         | YES     | ...     | NO           | NO   | NO         |
| Aria               | YES     | ...     | NO           | NO   | NO         |
| PERFORMANCE_SCHEMA | YES     | ...     | NO           | NO   | NO         |
| SEQUENCE           | YES     | ...     | YES          | NO   | YES        |
+--------------------+---------+---------+--------------+------+------------+
```

### 查看当前默认存储引擎

```SQL
SHOW VARIABLES LIKE 'storage\_engine%';
```

```txt
+----------------+--------+
| Variable_name  | Value  |
+----------------+--------+
| storage_engine | InnoDB |
+----------------+--------+
```

### 临时修改默认存储引擎

```SQL
SET default_storage_engine=存储引擎名
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 编码设置

### 设置字符集

修改`my.ini`文件。

```ini
[client]
; ...
default-character-set = utf8mb4

[mysql]
; ...
default-character-set = utf8mb4

[mysqld]
; ...
character-set-server = utf8mb4
character-set-client-handshake = FALSE
init_connect='SET NAMES utf8mb4'
collation-server = utf8mb4_general_ci
```

### 查看默认编码

```SQL
SHOW VARIABLES LIKE 'character\_set\_%';
SHOW VARIABLES LIKE 'collation%';
```

```txt
+--------------------------+---------+
| Variable_name            | Value   |
+--------------------------+---------+
| character_set_client     | utf8mb4 |
| character_set_connection | utf8mb4 |
| character_set_database   | utf8mb4 |
| character_set_filesystem | binary  |
| character_set_results    | utf8mb4 |
| character_set_server     | utf8mb4 |
| character_set_system     | utf8    |
+--------------------------+---------+

+----------------------+--------------------+
| Variable_name        | Value              |
+----------------------+--------------------+
| collation_connection | utf8mb4_general_ci |
| collation_database   | utf8mb4_general_ci |
| collation_server     | utf8mb4_general_ci |
+----------------------+--------------------+
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 备份

```bash
# 备份当前数据库
mysqldump -u${用户名} -p ${数据库名} > ${备份文件地址}.sql

# 恢复（登录后）
mysql>source ${备份文件地址}.sql;
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 库管理

### 查看库

```SQL
# 显示所有数据库
SHOW DATABASES;

# 显示数据库构造
SHOW CREATE DATABASE `库名`;
```

### 增删改

```SQL
# 创建新数据库
CREATE DATABASE
    `库名`
CHARACTER SET
    'utf8'
COLLATE
    'utf8_general_ci'
;
# utf8: 最大字符长度为3字节，遇到4字节的宽字符会插入异常
# utf8mb4: utf8的超集，用来兼容四字节的unicode
# ?_general_ci: 查询速度快
# ?_unicode_ci: 查询准确

# 修改数据库设置（主要是编码）
ALTER DATABASE
    `库名`
CHARACTER SET
    'utf8mb4'
COLLATE
    'utf8mb4_general_ci'
;

# 删除数据库
DROP DATABASE IF EXISTS `库名`;
```

### 选择数据库

```SQL
USE `库名`;
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 用户及其权限管理

### 查看用户

需要管理员身份。

```SQL
SELECT `User`,`Host`,`Password` FROM `mysql`.`user`;
```

```txt
+---------+-----------+----------+
| User    | Host      | Password |
+---------+-----------+----------+
| root    | localhost | *...     |
| root    | 127.0.0.1 |          |
| root    | ::1       |          |
|         | localhost |          |
+---------+-----------+----------+
```

### 用户管理

`%`即匹配任意字符任意长度。

- 当使用`%`代表host时，即代表任意地址主机；
- 当使用`192.168.1.%`代表host时，即代表该ip段内任意主机；
- 当使用`%.com`代表host时，即代表该域内任意主机。

#### 创建用户

```SQL
CREATE USER 'username'@'host' IDENTIFIED BY 'password';
INSERT INTO mysql.user (User,Host,Password) VALUES('username','host',PASSWORD('password'));
```

#### 修改密码

```SQL
# 修改指定用户密码
SET PASSWORD FOR 'username'@'host' = PASSWORD('new_password');
ALTER USER 'username'@'host' IDENTIFIED BY 'new_password';

# 修改当前用户密码
SET PASSWORD = PASSWORD('new_password');
```

#### 删除用户

```SQL
DROP USER IF EXISTS 'username'@'host';
```

### 权限管理

#### 查看权限

```SQL
# 查看当前用户权限
SHOW GRANTS;

# 查看指定用户权限
SHOW GRANTS FOR 'username'@'host';
```

#### 授权管理

```SQL
# 授予用户具体权限
GRANT 权限,... ON `库`.`表` TO 'username'@'host';
# 权限（增、删、改、查）= INSERT, DELETE, UPDATE, SELECT
# 权限（表结构）= CREATE, ALTER, DROP
# 权限（外键、索引）= REFERENCES, INDEX
# 权限（视图）= CREATE VIEW, SHOW VIEW
# 权限（临时表）= CREATE TEMPORARY TABLES
# 权限（存储过程、函数）= CREATE ROUTINE, ALTER ROUTINE, EXECUTE

# 授予用户一个数据库所有权限
# WITH GRANT OPTION: 用户可以将自己拥有的权限授权给别人
GRANT ALL PRIVILEGES ON `库`.* TO 'username'@'host' [WITH GRANT OPTION];
```

#### 撤权管理

```SQL
# 撤销用户具体权限
REVOKE 权限,... ON `库`.`表` FROM 'username'@'host';

# 撤销用户所有权限
REVOKE ALL ON *.* FROM 'username'@'host';
```

### 创建远程管理员用户

```SQL
CREATE USER 'root'@'%' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
SELECT `User`,`Host` FROM `mysql`.`user`;
```

### 创建数据库及其管理员

```SQL
# db_name: 数据库名
# user   : 用户名
# 1234   : 用户密码

CREATE DATABASE `db_name` CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci';
CREATE USER 'user'@'%' IDENTIFIED BY '1234';
REVOKE ALL ON *.* FROM 'user'@'%';
GRANT ALL PRIVILEGES ON `db_name`.* TO 'user'@'%' WITH GRANT OPTION;

# DROP DATABASE IF EXISTS `db_name`;
# DROP USER IF EXISTS 'user'@'%';
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 表管理

### 查看表

```SQL
# 查看表字段信息
DESC [TABLE] `表名`;
DESCRIBE [TABLE] `表名`;

# 查看表结构
SHOW CREATE TABLE `表名`;
SHOW CREATE TABLE `表名` \G;  # 命令行中

# 查看已有表
SHOW TABLES;
```

### 表操作

#### 创建表

```SQL
# 创建新表
CREATE TABLE 表名 (
    字段1 类型1 [约束1] [COMMENT '注解1'],
    字段2 类型2 [约束2] [COMMENT '注解2'],
    ...
    [ , PRIMARY KEY(字段) ]
    [ , [CONSTRAINT 外键约束名] FOREIGN KEY (字段) REFERENCES 表名(字段) ]
    [ , [UNIQUE] INDEX 索引名(字段) ]
);
# 约束 = NOT NULL | UNIQUE | CHECK (条件) | DEFAULT 值 | AUTO_INCREMENT[=起始值]

# 根据已存在的表创建表
CREATE TABLE `表1` (SELECT * FROM `表2`);
```

#### 修改表

```SQL
# 重命名表
RENAME TABLE `旧表名` TO `新表名`;
ALTER TABLE `旧表名` RENAME TO `新表名`;

# 添加字段
ALTER TABLE `表名` ADD 新字段名 类型;
ALTER TABLE `表名` ADD (字段 类型 [约束] [FIRST | AFTER 已存在字段名] [COMMENT '注解'], ...);

# 修改字段名和类型
ALTER TABLE `表名` CHANGE 旧字段名 新字段名 新类型;

# 修改字段类型
ALTER TABLE `表名` MODIFY 字段名 新类型;

# 删除字段
ALTER TABLE `表名` DROP 字段名;

# 删除外键约束
ALTER TABLE `表名` DROP FOREIGN KEY 外键约束名;
```

#### 删除表

```SQL
DROP TABLE IF EXISTS `表名`;
```

### 索引

```SQL
# 创建索引
CREATE [UNIQUE] INDEX `索引名称` [USING BTREE] ON `表名`(字段 [长度] [ASC | DESC], ...);
ALTER TABLE `表名` ADD [UNIQUE] INDEX `索引名称`(字段, ...) [USING BTREE];

# 查看索引
SHOW INDEX FROM `表名`;

# 删除索引
DROP INDEX `索引名称` ON `表名`;
ALTER TABLE `表名` DROP INDEX `索引名称`;
```

### 视图

操作视图就像操作表一样。

```SQL
# 创建视图
CREATE VIEW `视图名称` AS (
    SELECT ...
);

# 删除视图
DROP VIEW IF EXISTS `视图名称`;
```
