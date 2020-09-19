<link rel="stylesheet" href="https://zhmhbest.gitee.io/hellomathematics/style/index.css">
<script src="https://zhmhbest.gitee.io/hellomathematics/style/index.js"></script>

# [数据库维护](./index.html)

[TOC]

## 软件

### 数据库系统

- [MySQL](https://dev.mysql.com/downloads/mysql/)
- [MariaDB](https://downloads.mariadb.org/mariadb/)
- [SQL Server](https://www.microsoft.com/zh-cn/sql-server/sql-server-downloads)

### 数据库管理

- [Sqliteman](http://sqliteman.yarpen.cz/)
- [HeidiSQL](https://www.heidisql.com/download.php)
- [Navicat Premium](https://navicat.com.cn/products#navicat)

## 安装

### Windows

- [Download mariadb-10.1.38-winx64.zip](https://downloads.mariadb.org/mariadb/10.1.38/)
- [`mariadb-install.bat`](./src/mariadb-install.bat)
- [`mariadb-uninstall.bat`](./src/mariadb-uninstall.bat)

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
mysqladmin -u${用户名} -p[${用户名}]

# 登录管理
mysql -u${用户名} -p[${用户名}]
```

## 备份

```bash
# 备份当前数据库
mysqldump -u${用户名} -p ${数据库名} > ${备份文件地址}.sql

# 恢复（登录后）
mysql>source ${备份文件地址}.sql;
```

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
ALTER USER 'username'@'host' IDENTIFIED BY 'new_password';

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
