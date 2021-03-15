
### 应用

`tbl_sc`

@import "tbl_sc.sql"

#### 格式化学生成绩

```SQL
SELECT
    `name` AS '姓名',
    MAX(IF(`course` = '政治', ROUND(`score`, 2), NULL)) AS '政治',
    MAX(IF(`course` = '历史', ROUND(`score`, 2), NULL)) AS '历史',
    MAX(IF(`course` = '地理', ROUND(`score`, 2), NULL)) AS '地理',
    MAX(IF(`course` = '生物', ROUND(`score`, 2), NULL)) AS '生物',
    MAX(IF(`course` = '语文', ROUND(`score`, 2), NULL)) AS '语文',
    MAX(IF(`course` = '数学', ROUND(`score`, 2), NULL)) AS '数学',
    MAX(IF(`course` = '外语', ROUND(`score`, 2), NULL)) AS '外语',
    MAX(IF(`course` = '物理', ROUND(`score`, 2), NULL)) AS '物理',
    MAX(IF(`course` = '化学', ROUND(`score`, 2), NULL)) AS '化学'
FROM
    `tbl_sc`
GROUP BY
    `name`
;
```

@import "SC_FORMAT.csv"

#### 统计各科分数大于85分的人数和人数占比

```SQL
SELECT
    `course` AS '课程',
    COUNT(
        IF(`score`>85, TRUE, NULL)
    ) AS '满足人数',
    COUNT(`score`) AS '总人数',
    CONCAT(
        ROUND(
            COUNT(IF(`score`>85, TRUE, NULL))
            /
            COUNT(`score`) * 100, 2
        ),'%'
    )  AS '占比'
FROM
    `tbl_sc`
GROUP BY
    `course`
;
```

@import "SC_STATISTICS_85.csv"

#### 统计各分段的人数

```SQL
SELECT
    `course` AS '课程',
    SUM(CASE WHEN `score` BETWEEN 85 AND 100 THEN 1 ELSE 0 END) AS '优秀人数',
    SUM(CASE WHEN `score` BETWEEN 60 AND 84 THEN 1 ELSE 0 END) AS '及格人数',
    SUM(CASE WHEN `score`<60 THEN 1 ELSE 0 END) AS '不及格人数'
FROM
    `tbl_sc`
GROUP BY
    `course`
;
```

@import "SC_STATISTICS_PASS.csv"

#### 每门课程单科状元姓名及其分数

```SQL
SELECT
    t.*
FROM (
    SELECT
        course,
        MAX(score) AS score
    FROM
        tbl_sc
    GROUP BY
        course
) AS m
LEFT JOIN
    `tbl_sc` AS t
ON
    m.score = t.score
;
```

@import "SC_CHAMPION.csv"

#### 班级第三名的成绩

```SQL
SELECT * FROM tbl_sc WHERE `name` = (
    SELECT
        `name`
    FROM
        `tbl_sc`
    GROUP BY
        name
    ORDER BY
        AVG(`score`)
    LIMIT 2, 1  -- 1st=(0, 1)
);
```

@import "SC_3rd.csv"

#### 按平均成绩进行排名，并添加一列显示名次

- ***Step1*：计算每人平均成绩**

```SQL
DROP VIEW IF EXISTS `sc_avg`;
CREATE VIEW `sc_avg` AS (
    SELECT
        `name`,
        ROUND(AVG(`score`), 2) AS 'score'
    FROM
        `tbl_sc`
    GROUP BY
        `name`
);
SELECT * FROM `sc_avg`;
```

@import "SC_RANK_STEP1.csv"

- ***Step2*：连接并表**

```SQL
DROP VIEW IF EXISTS `sc_join`;
CREATE VIEW `sc_join` AS (
    SELECT
        `A`.`name`  AS 'name',
        `A`.`score` AS 'score',
        `B`.`name`  AS 'b_name',
        `B`.`score` AS 'b_score'
    FROM
        `sc_avg` AS A,
        `sc_avg` AS B
    WHERE
        A.score <= B.score
);
SELECT * FROM `sc_join`;
```

@import "SC_RANK_STEP2.csv"

- ***Step3*：统计排名**

```SQL
SELECT
    `name` AS '姓名',
    `score` AS '平均分',
    COUNT(DISTINCT(`b_score`)) AS '排名'
FROM
    `sc_join`
GROUP BY
    `name`
ORDER BY
    `score` DESC
;

DROP VIEW IF EXISTS `sc_avg`;
DROP VIEW IF EXISTS `sc_join`;
```

@import "SC_RANK_STEP3.csv"

- ***Step4*：小结**

```SQL
SELECT
    A.`name` AS '姓名',
    ROUND(A.`score`, 2) AS '平均分',
    COUNT(DISTINCT(B.`score`)) AS '排名'
FROM
    ( SELECT `name`, AVG(`score`) AS 'score' FROM `tbl_sc` GROUP BY `name` ) AS A,
    ( SELECT `name`, AVG(`score`) AS 'score' FROM `tbl_sc` GROUP BY `name` ) AS B
WHERE
    A.`score` <= B.`score`
GROUP BY
    A.`name`
ORDER BY
    A.`score` DESC
;
```
