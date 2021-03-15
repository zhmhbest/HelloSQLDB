-- USE test;
DROP TABLE IF EXISTS `tbl_salary`;
CREATE TABLE tbl_salary (
    `id`        INTEGER NOT NULL,
    `name`      VARCHAR(32) DEFAULT NULL,
    `salary`    FLOAT DEFAULT NULL,
    `monthId`   VARCHAR(6) COMMENT 'yyyyMM'
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;
INSERT INTO test.tbl_salary
(id,name,salary,monthId) VALUES
    (1001,'Olivia',870.0,'201906'),
    (1001,'Olivia',860.0,'201907'),
    (1001,'Olivia',820.0,'201908'),
    (1002,'Mark',1010.0,'201906'),
    (1002,'Mark',1050.0,'201907'),
    (1002,'Mark',1020.0,'201908'),
    (1002,'Mark',1100.0,'201909'),
    (1003,'Lucy',500.0,'201906'),
    (1003,'Lucy',502.0,'201907');
