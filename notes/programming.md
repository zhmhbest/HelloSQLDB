<link rel="stylesheet" href="https://zhmhbest.gitee.io/hellomathematics/style/index.css">
<script src="https://zhmhbest.gitee.io/hellomathematics/style/index.js"></script>

# [SQL Programming](./index.html)

[TOC]

## 自定义方法

### 函数

```SQL
# 创建
DELIMITER //
CREATE FUNCTION  函数名(字段 类型, ...) RETURNS 返回值类型
BEGIN
    -- 函数内容
    RETURN 值;
END //
DELIMITER ;

# 调用
SELECT `函数名`(参数, ...)

# 销毁
DROP FUNCTION [IF EXISTS] 函数名;
```

#### 例

```SQL
DELIMITER //
CREATE FUNCTION `add2`(`a` INT, `b` INT) RETURNS INT
BEGIN
    RETURN `a`+`b`;
END //
DELIMITER ;

SELECT `add2`(1, 2) AS 'Result';
DROP FUNCTION `add2`;
```

### 存储过程

```SQL
# 创建
DELIMITER //
CREATE PROCEDURE 过程名({ IN | OUT | INOUT } 字段 类型, ...)
BEGIN
    -- 存储过程内容
    -- 存储过程通过对OUT类型字段赋值返回内容。
END //
DELIMITER ;

# 调用
CALL   `过程名`(参数,@变量名,...)

# 销毁
DROP PROCEDURE [IF EXISTS] 过程名;
```

#### 例

```SQL
DELIMITER //
CREATE PROCEDURE `add2`(IN `a` INT, IN `b` INT, OUT `c` INT)
BEGIN
    SET `c` = `a`+`b`;
END //
DELIMITER ;

SET @result=0;
CALL `add2`(1, 2, @result);
SELECT @result AS 'Result';
DROP PROCEDURE `add2`;
```

### 触发器

```SQL
# 查看
SELECT * FROM  INFORMATION_SCHEMA.TRIGGERS;
SHOW TRIGGERS;

# 创建
DELIMITER //
CREATE TRIGGER 触发器名
    {BEFORE | AFTER} {INSERT | DELETE | UPDATE} ON `表名` FOR EACH ROW
BEGIN
    -- 程序体
END //
DELIMITER ;

# 销毁
DROP TRIGGER 触发器名;
```

### 定时器

```SQL
# 创建
CREATE EVENT [IF NOT EXISTS] 事件名称
ON SCHEDULE
    EVERY 1 SECOND
[ON COMPLETION [NOT] PRESERVE]
ENABLE
DO 语句;

# 启用/停止
ALTER EVENT 事件名称 ON COMPLETION PRESERVE {ENABLE | DISABLE};
```

## 内容编程

```SQL
DELIMITER //
CREATE PROCEDURE `main`()
BEGIN
    -- 在此编写测试内容
END //
DELIMITER ;
CALL `main`;
DROP PROCEDURE IF EXISTS `main`;
```

### 变量

```SQL
-- 声明会话变量
SET @hello='Hello world!';
SELECT @hello;

DELIMITER //
CREATE PROCEDURE `main`()
BEGIN

    -- 声明过程变量（仅能在存储过程或函数中使用）
    DECLARE `pi` float DEFAULT 3.14;
    DECLARE `i` int; # 默认初始化为null
    SELECT `pi`,`i`;

    -- 修改变量
    SET `i`=0;
    SELECT `i`;

END //
DELIMITER ;
CALL `main`;
DROP PROCEDURE IF EXISTS `main`;
```

### 条件语句

```SQL
DELIMITER //
CREATE PROCEDURE `main`()
BEGIN
    DECLARE `a`,`b`,`c` int;
    DECLARE `d` int DEFAULT -1;
    SELECT `a`,`b`,`c`,`d`;

    -- IFNULL()
    SET `a`=`IFNULL`(`a`, 0);       # 若为NULL返回0，反则返回原值

    -- IF()
    SET `b`=IF(`b` IS NULL, 0, 1);  # 若为NULL返回0，反则返回1

    -- IF ... ELSE ..
    IF `c` IS NULL THEN             # 若为NULL返回0，反则返回1
        SET `c`= 0;
    ELSE
        SET `c`= 1;
    END IF;

    -- CASE WHEN
    CASE `d`
        WHEN -1 THEN
            SET `d`=0;
        ELSE
            SET `d`=1;
    END CASE;

    SELECT `a`,`b`,`c`,`d`;
END //
DELIMITER ;
CALL `main`;
DROP PROCEDURE IF EXISTS `main`;
```

### 循环语句

**WHILE**

```SQL
DELIMITER //
CREATE PROCEDURE `main`()
BEGIN
    DECLARE `i` INT DEFAULT 3;
    WHILE `i`>0 DO
        SET `i`=`i`-1;
        SELECT `i`;
    END WHILE;
END //
DELIMITER ;
CALL `main`;
DROP PROCEDURE IF EXISTS `main`;
```

**REPEAT**

```SQL
DELIMITER //
CREATE PROCEDURE `main`()
BEGIN
    DECLARE `i` INT DEFAULT 3;
    REPEAT
        SET `i`=`i`-1;
        SELECT `i`;
    UNTIL `i`=0 END REPEAT;
END //
DELIMITER ;
CALL `main`;
DROP PROCEDURE IF EXISTS `main`;
```

**LOOP**

```SQL
DELIMITER //
CREATE PROCEDURE `main`()
BEGIN
    DECLARE `i` INT DEFAULT 3;
    LOOP_LABLE:LOOP
        SET `i`=`i`-1;
        SELECT `i`;
        IF `i`=0 THEN
            LEAVE LOOP_LABLE;
        END IF;
    END LOOP;
END //
DELIMITER ;
CALL `main`;
DROP PROCEDURE IF EXISTS `main`;
```
