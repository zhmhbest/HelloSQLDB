
### 应用

**SC**

@import "SC.sql"

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
    `SC`
GROUP BY
    `name`
;
```

@import "SC_FORMAT.csv"

#### 统计各科分数大于85分的人数和人数占比

>使用`SC`表

```SQL
SELECT
    `course` AS '课程',
    COUNT(IF(`score`>85, TRUE, NULL)) AS '满足人数',
    COUNT(`score`) AS '总人数',
    CONCAT(ROUND(COUNT(IF(`score`>85, TRUE, NULL)) / COUNT(`score`) * 100, 2), '%')  AS '占比'
FROM
    `SC`
GROUP BY
    `course`
;
```

@import "SC_STATISTICS1.csv"

#### 统计各分段的人数

```SQL
SELECT
    `course` AS '课程',
    SUM(CASE WHEN `score` BETWEEN 85 AND 100 THEN 1 ELSE 0 END) AS '优秀人数',
    SUM(CASE WHEN `score` BETWEEN 60 AND 84 THEN 1 ELSE 0 END) AS '及格人数',
    SUM(CASE WHEN `score`<60 THEN 1 ELSE 0 END) AS '不及格人数'
FROM
    `SC`
GROUP BY
    `course`
;
```

@import "SC_STATISTICS2.csv"

#### 按平均成绩进行排名，并添加一列显示名次

>使用`SC`表

- ***Step1*：显示平均成绩**

```SQL
DROP VIEW IF EXISTS `SC_AVG`;
CREATE VIEW `SC_AVG` AS (
    SELECT
        `name`,
        ROUND(AVG(`score`), 2) AS 'score'
    FROM
        `SC`
    GROUP BY
        `name`
);
SELECT * FROM `SC_AVG`;
```

@import "SC_RANK_STEP1.csv"

- ***Step2*：连接并表**

```SQL
DROP VIEW IF EXISTS `SC_JOIN`;
CREATE VIEW `SC_JOIN` AS (
    SELECT
        `A`.`name`  AS 'nameA',
        `A`.`score` AS 'scoreA',
        `B`.`name`  AS 'nameB',
        `B`.`score` AS 'scoreB'
    FROM
        `SC_AVG` AS `A`,
        `SC_AVG` AS `B`
    WHERE
        `A`.`score` <= `B`.`score`
);
SELECT * FROM `SC_JOIN`;
```

@import "SC_RANK_STEP2.csv"

- ***Step3*：统计排名**

```SQL
SELECT
    `nameA` AS '姓名',
    `scoreA` AS '平均分',
    COUNT(DISTINCT(`scoreB`)) AS '排名'
FROM
    `SC_JOIN`
GROUP BY
    `nameA`
ORDER BY
    `scoreA` DESC
;

DROP VIEW IF EXISTS `SC_AVG`;
DROP VIEW IF EXISTS `SC_JOIN`;
```

@import "SC_RANK_STEP3.csv"

- ***Step4*：小结**

```SQL
SELECT
    `A`.`name` AS '姓名',
    `A`.`score` AS '平均分',
    COUNT(DISTINCT(`B`.`score`)) AS '排名'
FROM
    ( SELECT `name`, AVG(`score`) AS 'score' FROM `SC` GROUP BY `name` ) AS `A`,
    ( SELECT `name`, AVG(`score`) AS 'score' FROM `SC` GROUP BY `name` ) AS `B`
WHERE
    `A`.`score` <= `B`.`score`
GROUP BY
    `A`.`name`
ORDER BY
    `A`.`score` DESC
;
```

- **补充：Python生成排名模板**

```py
def get_sql_rank(
        to_be_sorted_view: str,
        to_be_sorted_field: str,
        to_be_classified_field: str,
        to_be_sorted_name='得分',
        to_be_classified_name='类别',
        rank_name='排名',
        part_name_l='A',
        part_name_r='B',
        how_to_order='DESC'
):
    """
    生成排序模板
    :param to_be_sorted_view: 待排序视图
    :param to_be_sorted_field: 待排序字段
    :param to_be_classified_field: 待分类字段
    :param to_be_sorted_name:
    :param to_be_classified_name:
    :param rank_name:
    :param part_name_l: 左表临时名
    :param part_name_r: 右表临时名
    :param how_to_order: DESC:第一名在最前 | ASC:第一名在最后
    :return: sql
    """
    to_be_sorted_view = to_be_sorted_view.strip()
    if '(' == to_be_sorted_view[0] and ')' == to_be_sorted_view[-1]:
        to_be_sorted_view = ' '.join([line.strip() for line in to_be_sorted_view.split('\n')])
    else:
        to_be_sorted_view = f"`{to_be_sorted_view}`"

    sql_template = f"""
    SELECT
        `{part_name_l}`.`{to_be_classified_field}` AS {to_be_classified_name},
        `{part_name_l}`.`{to_be_sorted_field}` AS {to_be_sorted_name},
        COUNT(DISTINCT(`{part_name_r}`.`{to_be_sorted_field}`)) AS {rank_name}
    FROM
        {to_be_sorted_view} AS `{part_name_l}`,
        {to_be_sorted_view} AS `{part_name_r}`
    WHERE
        `{part_name_l}`.`{to_be_sorted_field}` <= `{part_name_r}`.`{to_be_sorted_field}`
    GROUP BY
        `{part_name_l}`.`{to_be_classified_field}`
    ORDER BY
        `{part_name_l}`.`{to_be_sorted_field}` {how_to_order}
    ;
    """
    return sql_template


if __name__ == '__main__':
    sql = get_sql_rank('''
    (
        SELECT
            `name`,
            AVG(`score`) AS 'score'
        FROM
            `SC`
        GROUP BY
            `name`
    )
    ''', 'score', 'name')
    print(sql)
```

<!-- ■■■■■■■■ ■■■■■■■■ ■■■■■■■■ ■■■■■■■■-->
