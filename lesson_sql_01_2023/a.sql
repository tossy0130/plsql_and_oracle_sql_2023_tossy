-- ********* SQL練習問題 – 問5 （副問い合わせ）
--------- キックオフ日時と対戦国の国名をキックオフ日時の早いものから順に表示 , pairings, countries
SELECT
    P.KICKOFF AS キックオフ日時,
    (
        SELECT
            C1.NAME
        FROM
            COUNTRIES C1
        WHERE
            P.MY_COUNTRY_ID = C1.ID
    ) AS 国名1,
    (
        SELECT
            C2.NAME
        FROM
            COUNTRIES C2
        WHERE
            P.ENEMY_COUNTRY_ID = C2.ID
    ) AS 国名2
FROM
    PAIRINGS P
ORDER BY
    キックオフ日時 ASC;

--- **************
--- inser join で書くと
--- ***************
SELECT
    P.KICKOFF AS キックオフ日時,
    C1.NAME   AS 国名1,
    C2.NAME   AS 国名2
FROM
    PAIRINGS  P
    LEFT JOIN COUNTRIES C1
    ON C1.ID = P.MY_COUNTRY_ID
    LEFT JOIN COUNTRIES C2
    ON C2.ID = P.ENEMY_COUNTRY_ID
ORDER BY
    キックオフ日時 ASC;

-- ********* END ***********

-- ********* SQL練習問題 – 問59
----- 全ての試合の国名と選手名、得点時間を表示してください。オウンゴール（player_idがNULL）は表示
SELECT
    C.NAME,
    P.NAME,
    G.GOAL_TIME
FROM
    COUNTRIES C
    JOIN PLAYERS P
    ON C.ID = P.COUNTRY_ID JOIN GOALS G
    ON G.PLAYER_ID = P.UNIFORM_NUM
WHERE
    G.GOAL_TIME IS NOT NULL;

-- ********* SQL練習問題 – 問60
------- 全ての試合のゴール時間と選手名を表示してください。左側外部結合を使用してオウンゴール（player_idがNULL）も表示してください
SELECT
    G.GOAL_TIME,
    P.UNIFORM_NUM,
    P.POSITION,
    P.NAME
FROM
    GOALS   G
    LEFT OUTER JOIN PLAYERS P
    ON P.UNIFORM_NUM = G.ID;

-- ********* SQL練習問題 – 問 68
------- 各ポジションごと（GK、FWなど）に最も身長と、その選手名、所属クラブを表示してください。ただし、FROM句に副問合せを使用してください。
SELECT
    P.POSITION,
    P.最大身長,
    P2.NAME,
    P2.CLUB
FROM
    (
        SELECT
            POSITION,
            MAX(HEIGHT) AS 最大身長
        FROM
            PLAYERS
        GROUP BY
            POSITION
    )P       
    LEFT OUTER JOIN PLAYERS P2
    ON P.最大身長 = P2.HEIGHT
    AND P.POSITION = P2.POSITION;

-- ********* SQL練習問題 – 問 69
------- 各ポジションごと（GK、FWなど）に最も身長と、その選手名を表示してください。ただし、SELECT句に副問合せを使用してください。
SELECT
    P1.POSITION,
    MAX(P1.HEIGHT),
    (
        SELECT
            P2.NAME
        FROM
            PLAYERS P2
        WHERE
            MAX(P1.HEIGHT) = P2.HEIGHT
            AND P1.POSITION = P2.POSITION
    ) AS 名前
FROM
    PLAYERS P1
GROUP BY
    P1.POSITION;

-- ********* Q 問69
------- 各グループの最上位と最下位を表示し、その差が50より大きいグループを抽出
SELECT
    C.GROUP_NAME,
    MAX(C.RANKING) AS R_MAX,
    MIN(C.RANKING) AS R_MIN
FROM
    COUNTRIES C
GROUP BY
    C.GROUP_NAME
HAVING
    MAX(C.RANKING) - MIN(C.RANKING) >= 50;

-- ********* SQL練習問題 – 問58
----- 全ての選手の所属国と名前、背番号を表示
SELECT
    C.NAME,
    P.NAME,
    P.UNIFORM_NUM
FROM
    COUNTRIES C
    JOIN PLAYERS P
    ON P.COUNTRY_ID = C.ID;

-- ********* Q 03
------ 国の平均身長を高い方から順に表示 , 「副問い合わせ」
SELECT
    AVG(P.HEIGHT) AS 平均身長,
    (
        SELECT
            C.NAME
        FROM
            COUNTRIES C
        WHERE
            C.ID = P.COUNTRY_ID
    ) AS 国名
FROM
    PLAYERS P
GROUP BY
    P.COUNTRY_ID
ORDER BY
    平均身長 DESC;

-- ********* Q 02
------- 全ゴールキーパーの平均身長、平均体重を表示
SELECT
    AVG(P.HEIGHT) AS 平均身長,
    AVG(P.WEIGHT) AS 平均体重
FROM
    PLAYERS P
WHERE
    P.POSITION = 'GK';

-- ********* Q 01 , MIN , MAX , group by
----- 各グループの中でFIFAランクが最も高い国と低い国のランキング番号を表示してください。
SELECT
    C.GROUP_NAME   AS グループ,
    MIN(C.RANKING) AS ランキング最上位,
    MAX(C.RANKING) AS ランキング最下位
FROM
    COUNTRIES C
GROUP BY
    C.GROUP_NAME
ORDER BY
    グループ ASC;