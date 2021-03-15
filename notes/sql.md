<link rel="stylesheet" href="https://zhmhbest.gitee.io/hellomathematics/style/index.css">
<script src="https://zhmhbest.gitee.io/hellomathematics/style/index.js"></script>

# [SQL Common](./index.html)

[TOC]

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
# 删除行数据
DELETE FROM `表名` WHERE 条件;

# 清空表内所有数据
TRUNCATE TABLE `表名`;
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 查找

@import "query/base.md"

@import "query/condition.md"

@import "query/union.md"

@import "query/link/index.md"

@import "query/group/index.md"

@import "query/empty_null.md"

@import "query/application/index.md"

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
