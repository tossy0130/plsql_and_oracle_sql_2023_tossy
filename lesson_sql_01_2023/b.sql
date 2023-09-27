-- ********* SQL練習問題 – 問71 UNION ALL
------ 身長が195㎝より大きいか、体重が95kgより大きい選手を抽出。
------ただし、以下の画像のように、どちらの条件にも合致する場合には2件分のデータとして抽出
------た、結果はidの昇順
SELECT
    P1.ID,
    P1.POSITION,
    P1.NAME,
    P1.HEIGHT,
    P1.WEIGHT
FROM
    PLAYERS P1
WHERE
    P1.HEIGHT > 195 UNION ALL
    SELECT
        P1.ID,
        P1.POSITION,
        P1.NAME,
        P1.HEIGHT,
        P1.WEIGHT
    FROM
        PLAYERS P1
    WHERE
        P1.WEIGHT > 95
    ORDER BY
        ID ASC;

-- ********* SQL練習問題 – 問70 UNION
------ 980年生まれと、1981年生まれの選手が何人いるか調べる。日付関数は使用せず、UNION句を使用
SELECT
    '1980',
    COUNT(P1.ID)
FROM
    PLAYERS P1
WHERE
    P1.BIRTH >= '1980-01-01'
    AND P1.BIRTH < '1981-01-01' UNION
    SELECT
        '1981',
        COUNT(P2.ID)
    FROM
        PLAYERS P2
    WHERE
        P2.BIRTH >= '1981-01-01'
        AND P2.BIRTH < '1982-01-01';