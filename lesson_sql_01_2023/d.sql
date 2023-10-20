-------------- Q 04
--- 各国の平均身長を高い方から順に表示してください。ただし、FROM句はplayersテーブルとして、テーブル結合を使わず副問合せを用いてください。
SELECT
    (
        SELECT
            C.NAME
        FROM
            COUNTRIES C
        WHERE
            C.ID = P.COUNTRY_ID
    ),
    AVG(P.HEIGHT) AS 身長
FROM
    PLAYERS   P
GROUP BY
    P.COUNTRY_ID
ORDER BY
    身長 DESC;

-------------- Q 03
--- 各国の平均身長を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。
SELECT
    C.NAME        AS 国名,
    AVG(P.HEIGHT) AS 平均身長
FROM
    COUNTRIES C
    JOIN PLAYERS P
    ON P.COUNTRY_ID = C.ID
GROUP BY
    国名
ORDER BY
    平均身長 DESC;

-------------- Q 02
--- 全ゴールキーパーの平均身長、平均体重を表示してください
SELECT
    AVG(P.HEIGHT) AS 平均身長,
    AVG(P.WEIGHT) AS 平均体重
FROM
    PLAYERS P
GROUP BY
    P.POSITION
HAVING
    P.POSITION = 'GK';

-------------- Q 01
--- 各グループの中でFIFAランクが最も高い国と低い国のランキング番号を表示してください。
SELECT
    C.GROUP_NAME,
    MIN(C.RANKING),
    MAX(C.RANKING)
FROM
    COUNTRIES C
GROUP BY
    C.GROUP_NAME
ORDER BY
    C.GROUP_NAME;

-------------------------------------------- END

-------------- Q 24
--- 問題：身長の高い選手6位～20位を抽出し、以下の項目を表示してください。
SELECT
    NAME,
    HEIGHT,
    WEIGHT
FROM
    PLAYERS
ORDER BY
    HEIGHT DESC LIMIT 15 OFFSET 4;

-------------------------------------------- END


-------------- Q 23
--- 問題：身長の高い選手ベスト5を抽出し、以下の項目を表示してください。
SELECT
    P.NAME,
    P.HEIGHT,
    P.WEIGHT
FROM
    PLAYERS P
ORDER BY
    P.HEIGHT DESC LIMIT 5;

-------------------------------------------- END