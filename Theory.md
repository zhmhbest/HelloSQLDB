# 数据库设计

## 基础知识

### 关系、实体、属性

#### 关系

一个关系就对应一个基本表。

#### 实体

客观存在并可相互区别的事物，对应表中的一个元组（即一行数据）。

#### 属性

实体所具有的某一特性，对应表中的一个字段。

### 码（键）

#### 码（key）

唯一标识实体的属性集，包含所有的属性。

#### 超码（super key）

若关系中的，某一属性（或多个属性组成的组）能唯一的标识关系中的每一个实体，则该属性（或属性组）就是超码。

#### 候选码（candidate key）

超码的一个子集，候选码的任意一个子集都不再是超码，即候选码是最小的超码。一个关系中可能存在多个候选码。

#### 主属性

所有候选码中都包含的属性称为主属性。

#### 非主属性

除了主属性之外的存在于关系之中的其它属性。

#### 主码（primary key）

从候选码中选出的作为唯一标识关系中实体的码。

#### 外码（foreign key）

若一个关系中的某一属性是另一个关系中的主码，则这个属性为外码。外码的值等于空或其对应的主码中的一个值。

### 设计步骤

1. 需求分析
1. 概念结构设计
1. 逻辑结构设计：把概念阶段设计的E-R图转换为与选用DBMS产品所支持的数据模型相符合的逻辑结构。
1. 物理结构设计：为给定的逻辑模型选取一个最适合应用要求的物理结构的过程。
1. 数据库实施
1. 数据库的运行和维护

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->
&nbsp;<br/>&nbsp;<br/>
<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 关系代数运算

#### 基础运算

- 并
- 交
- 差
- 笛卡尔积

#### 专门运算符

- 选择
- 投影
- 连接
    - 非等值连接
    - 等值连接
    - 自然连接
    - 外连接
    - 左外连接
    - 右外连接
- 除法

#### 关系代数等价规则

- 连接、笛卡尔积交换律
- 连接、笛卡尔积结合律
- 投影串接定律
- 选择串接定律
- 选择、投影的交换律
- 选择、笛卡尔积的交换律
- 选择、并操作分配律
- 选择、差运算分配律
- 选择、自然连接分配律
- 投影、笛卡尔积分配律
- 投影、并操作分配律

#### 查询优化策略

1. 选择运算尽可能先做。
1. 把投影运算和选择运算同时进行。
1. 把投影同其前或后的双目运算结合起来。
1. 把某些选择同在它前面要执行的笛卡尔积结合起来成为一个连接运算。
1. 找出公共子表达式。

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->
&nbsp;<br/>&nbsp;<br/>
<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 数据库安全性与完整性

### 安全标准

| EAL  | TCSEC | Defination |
| ---- | ----- | ---------- |
| EAL1 |       | 功能测试 |
| EAL2 | C1    | 结构测试 |
| EAL3 | C2    | 系统地检查和测试 |
| EAL4 | B1    | 系统地设计、测试和复查 |
| EAL5 | B2    | 半形式化设计和测试 |
| EAL6 | B3    | 半形式化验证的设计和测试 |
| EAL7 | A1    | 形式化验证的设计和测试 |

### 数据库安全控制方法

- 用户身份鉴别
- 自主存取控制
    - 定义用户权限： 数据库对象、操作类型
    - 合法权限检查
- 强制存取控制

### 关系的完整性

- **实体完整性**：主码不能取空值（null value），空值即“不知道”、“不存在”或“无意义”的值。
- **参照完整性**：外码的值等于空或其对应的主码中的一个值。
- **用户定义的完整性**

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->
&nbsp;<br/>&nbsp;<br/>
<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 数据库规范化

### 数据依赖

一个关系内部属性与属性之间的一种约束关系。这种约束关系通过属性间的相等与否体现出来的数据间相关联系。它是现实世界属性之间相互联系的抽象，是数据内在的性质，语义的体现。数据依赖包括函数依赖和多值依赖。

### 函数依赖

对于关系模式属性集的两个子集X和Y，在任意一个可能的关系上，不存在X属性值相同而Y属性值不同，则称X函数确定Y，记作X→Y，其中X称为**决定因素**。

#### 平凡函数依赖：

X→Y且Y∈X。eg：(A, B)→B。

#### 非平凡的函数依赖

X→Y且Y∉X。eg：(A, B)→C。

#### 部分函数依赖

X→Y但Y不完全函数依赖于X，记作![](data:image/jpeg;base64,/9j/4AAQSkZJRgABAgAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAAWADEDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD34kKMkgD3oLAEAkZPSqWtQQXOi3kFw6pFJCylm6KSMA/nWJ4WiXWNH03Ub2KNmt4vKhi258tl+V2Of4iV/AfWgDY124mttGuGtiRcuBFDgjO9iFXr7kUulx3yCc3khKFx5KOQXVQACWI4yTk45x6+kdzNcyy7W0Tz0ifdG7SR9R0YAnj+dU7XWNam1uW0l0CRLRSv+kmZRtBHPH8X4UAb5IAySB9aMjIGRk9KzPEdjFqPh6+t5iAPJZlc/wADAZB/Oqnh6JtStLLWby3RJWt1FvHjJjUgEn6t19hgetAG/RRRQBRksJJ9TjuZrgPbxDMdvs4D/wB8nPJ649M1Fo+kvpX2wG581Li4acLs2hC3UDk8UUUAadFFFAFDWdPk1XS5rGO6NsJhsd1XcdvcDnv0q1bQi2tYoAQRGgQYGOAMdKKKAJaKKKAP/9k=)。

#### 完全函数依赖

X→Y且X任何真子集X’都有![](data:image/jpeg;base64,/9j/4AAQSkZJRgABAgAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAAUADcDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD3m6klhtJZYYhLKilljLbdxHbODisqy16XU9N0+4sLWOWW6QSOjTFVhXnJLbTzkYxjnB9Di3fXk4njsrOJ/PlBzO0TGOIepOME+gz9cVk+ErQ6U+p6X5MqxRXTSQStCyq6MAeuACQc9KANfSNRfVLR7kweVH5rpEd2fMQHAfoMZweKXUr8WMcJ3RKZJQpaVsKqj5nJPbChvxxVie1huYPIkUmPj5VYr/KufufCtlqV9cRzQzR2yQeUh8wkszcsw3EjoAPxNAHTAgjIORWPda4bLX00+5gSO3e2e4S5aXrsI3Ltx1AOevSp9H0Sw0K1Nvp8TRxk5bdIzZPryePwrJ1SE6l4y0iN7Sc2tkssrTGF9jSEAKu7GPU+nAoA3dPuLi6tfOuLX7MWY7EL7jtzwTwMEjnHairVFABRRRQAUUUUAFFFFABRRRQB/9k=)，记作![](data:image/jpeg;base64,/9j/4AAQSkZJRgABAgAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAAYADEDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD3qe5gtYvNuJo4Y843SOFH5mmve2sbRK9zCrTf6sNIAX+nrVLxFHb3Gg3drcAsLmMwoqjLM5HygD1zz+GelUPCgOpaRZareN5t0IzEoIwIdp2sAPUlTk9e3A4oA0Nfu7iz0iR7PP2t2SOEAA5ZmA78etT6f9oaMyzSTEOMLHMiqyEEgk7eOeDVG7j1e4lRjpunSCGTfEWvZBg9iQI+tVrK48Vtrkq3Vlp66blRuE7FhxztO0Z/ED60Ab1xcwWkXm3E0cMY43yOFH5mm/bbUPEhuYd03+qXzBl/931/CoNZgt7nRL6G6bbbvA4kbGdowefw61meFori70mw1PUQDctbKsQ7IhA5Hu2AT+AoA6GiiigCkumxDVG1BpZpJdmxVdsrGO+0Y4zgZNN0vSLfSEmS2eUrNIZXEj7vnPUj0zRRQBfooooAqalp0Oq2MlncNIIZQVcRttJHpmpraBbW2jgQkpGoVc9QB0FFFAEtFFFAH//Z)。

#### 传递函数依赖

X→Y(Y∉X)，![](data:image/jpeg;base64,/9j/4AAQSkZJRgABAgAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAARAC8DASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD2rUtQubLVNNiURC1upDE7spJVsEgDnvgjpVjT7ie6WWd/L+zu3+jlVILJ/ePJznt04+tZXiaE391pGn/ZZpYmvFmncQlkVFBOGOMDJwPzrengiuYHgmjV4nGGRhwRQBX1G8+xxREMitJKq7nOFCj5nJPbCKxq1HIk0ayROrowyrKcgj2Nc/deFtNvtRdJLCOO3W22qyKBl3JBI9wB1/2q0NL0bTfD9m8Wn2ohj+8+3Ls2B+JP0oAg1PV303WtPgmaGOyuVl3SuCCjIu4DOcAEZ/KrthLeTrLLcpGkbOfIUKQ+zsWyep9O36Dnde+06lp6apHbXWbK7jktbX7O29yr4ZmUjPKk4H498DrI3EkauoYBgCAylT+IPIoAdRRRQAUUUUAFFFFAH//Z) ，Y→Z(Z∉Y)，则![](data:image/jpeg;base64,/9j/4AAQSkZJRgABAgAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAAZADYDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD3+iszxBeXun6JcXtisTywL5jJKpYMg+9jBHOOfwpLW9utQuYpLSS3bTxGC8pibMjnnCfNjGOp5weOSDgAzptZvPtk6IHjX7elsgkUD5VQSMRgEncN3XtjFaNzqbRRRSYcLJEzExpv6EAEEkcDOeRg5p8ulwyLerJK4+1S+blTgofLVOPXhe/rUOpJpUawR3d5Ha5TyoR5iouOMgA/Kc8DBBGO1AC6HqMmoRM8siuzKsowAAFJYDGM8fJnkk8mtaqWn6algG2zyTFlC7pAmcAkj7qj+8ar6td3dhDPeG5tLaygj3M0sLSMx9gGXHYAckk0AatFZuhXGpXelx3GqwxQXEhLCKNSNqdtwJPzdz6ZxRQA2687UbqXTjFNDaBP30xGPNB42Ke3uevp6iDwmt1D4et7S8gkhltcwjeMblH3SPwx+RrbooArXOn2V6ym6s7ecqMKZYw2PpkVQuPCug3TxPLpNoTGcqFjCgn3Axn8a2KKAGxxRwxLFEipGowqqMAD0Arl7lbnUdeabULG7/s+xbNrbrGG8+QZ/eNzjA/hB+tdVRQBDaSTTWqSTwmGRhkxk5KjPAOO+MZ96KmooA//2Q==)。

### 范式

关系数据库中的关系是满足一定要求的，满足不同程度要求的为不同范式。一个低一级范式的关系模式通过模式分解可以转换为若干个高一级范式的关系模式的集合。

#### 1NF

满足最低要求的范式，即属性不可再分。不满足就不是关系数据库。

#### 2NF

满足1NF，且每一个非主属性完全函数依赖于任何一个候选码。

#### 3NF

满足1NF，且每一个非主属性既不部分依赖于码也不传递依赖于码。

#### BCNF

每一个决定因素都包含码。

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->
&nbsp;<br/>&nbsp;<br/>
<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 并发控制

### 封锁类型

- 排他锁（写锁X）
- 共享锁（读锁S）

### 封锁协议

- 一级：修改数据前加排他锁，事务结束时释放。
- 二级：一级基础上，读取数据前加共享锁，读取完成后释放。
- 三级：一级基础上，读取数据前加共享锁，事务结束时释放。

### 活锁和死锁

#### 活锁

当多个事务请求封锁同一数据对象时，封锁子系统未按请求先后次序给锁，造成先请求的事务永远等待的情形。解决方法：先来先服务策略。

#### 死锁

两事务在已封锁了一个数据的情况下，再请求对方已封锁的数据，造成相互永久等待的现象。解决方法：死锁预防（一次封锁、顺序封锁）、死锁诊断与解除（超时法、等待图法）等。通常使用死锁诊断与解除，选择一个处理死锁代价最小的事务，将其撤销，释放此事务所有锁。

### 并发调度可串行性

多个事务的并发执行是正确的，当且仅当其结果与按某一次序串行的执行这些事务时的结果相同，成这种调度策略为可串行性的调度。冲突操作主要为对同一数据的读写操作和写写操作。冲突可串行化调度是可串行化调度的充分条件。

### 两段锁协议

分为两个阶段：获得封锁（扩展阶段）、释放封锁（收缩阶段）。事务遵守两段锁协议是可串行化调度的充分条件。

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->
&nbsp;<br/>&nbsp;<br/>
<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->

## 数据库备份与恢复

### 故障的种类

- 事务内部故障
- 系统故障
- 介质故障
- 计算机病毒

### 故障恢复的方法

- 数据转存
- 登记日志文件

### 故障恢复的策略

- 事务故障恢复：利用日志文件对已做修改进行撤销。
- 系统故障恢复：撤销故障发生时未完成事务，重做已完成事务。
- 介质故障恢复：重装数据库，重做已完成的事务。

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->
&nbsp;<br/>&nbsp;<br/>
<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->
