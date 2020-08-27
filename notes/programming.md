<link rel="stylesheet" href="https://zhmhbest.gitee.io/hellomathematics/style/index.css">
<script src="https://zhmhbest.gitee.io/hellomathematics/style/index.js"></script>

# [SQL Programming](./index.html)

[TOC]

## 存储过程

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

## 触发器

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

## 定时器

```SQL
# 创建
CREATE EVENT IF NOT EXISTS 事件名称
ON SCHEDULE EVERY 1 SECOND
ON COMPLETION PRESERVE
ENABLE DO CALL 存储过程();

# 启用/停止
ALTER EVENT 事件名称 ON  COMPLETION PRESERVE {ENABLE | DISABLE};
```

## 内容编程

### 变量

```SQL
# 声明
DECLARE 变量名 变量类型 [DEFAULT 值];

# 赋值
SET @hello='Hello';
SELECT @hello;
```

### 条件语句（IF）

```SQL
IF 条件 THEN
    -- 语句1;
ELSE
    -- 语句2;
END IF ;
```

### 条件语句（CASE）

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

### 循环语句

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
