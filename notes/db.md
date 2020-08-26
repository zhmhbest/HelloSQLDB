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
