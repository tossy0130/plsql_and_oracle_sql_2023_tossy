-- ********* 問19
------- 年齢ごとの選手数を表示
------- 年齢はワールドカップ開催当時である2014-06-13を使って算出
SELECT
    EXTRACT(YEAR FROM AGE(DATE '2014-06-13', P.BIRTH)) AS 年齢,
    COUNT(P.ID)                                        AS 人数
FROM
    PLAYERS P
GROUP BY
    年齢
ORDER BY
    年齢 ASC;

------------ END

-- ********* 問18
------- ブラジル（my_country_id = 1）対クロアチア（enemy_country_id = 4）戦のキックオフ時間（現地時間）を表示
SELECT
    P.KICKOFF,
    P.KICKOFF - INTERVAL '12 hours' AS 現地時間
FROM
    PAIRINGS P
WHERE
    P.MY_COUNTRY_ID = 1
    AND P.ENEMY_COUNTRY_ID = 4;

------------ END



-- ********* 問17 (★★★　むず)
------- 得失点差を追加する
SELECT
    P1.KICKOFF,
    C1.NAME    AS MY_COUNTRY,
    C2.NAME    AS ENEMY_COUNTRY,
    C1.RANKING AS MY_RANKING,
    C2.RANKING AS ENEMY_RANKING,
    (
        SELECT
            COUNT(G1.ID)
        FROM
            GOALS G1
        WHERE
            P1.ID = G1.PAIRING_ID
    ) AS MY_GOALS,
    (
        SELECT
            COUNT(G2.ID)
        FROM
            GOALS    G2
            LEFT JOIN PAIRINGS P2
            ON P2.ID = G2.PAIRING_ID
        WHERE
            P2.MY_COUNTRY_ID = P1.ENEMY_COUNTRY_ID
            AND P2.ENEMY_COUNTRY_ID = P1.MY_COUNTRY_ID
    ) AS 追加カラムENEMY_GOALS,
    (
        SELECT
            COUNT(G1.ID)
        FROM
            GOALS G1
        WHERE
            P1.ID = G1.PAIRING_ID
    ) - (
        SELECT
            COUNT(G2.ID)
        FROM
            GOALS    G2
            LEFT JOIN PAIRINGS P2
            ON P2.ID = G2.PAIRING_ID
        WHERE
            P2.MY_COUNTRY_ID = P1.ENEMY_COUNTRY_ID
            AND P2.ENEMY_COUNTRY_ID = P1.MY_COUNTRY_ID
    ) 得失点差
FROM
    PAIRINGS  P1
    LEFT JOIN COUNTRIES C1
    ON C1.ID = P1.MY_COUNTRY_ID
    LEFT JOIN COUNTRIES C2
    ON C2.ID = P1.ENEMY_COUNTRY_ID
WHERE
    C1.GROUP_NAME = 'C'
    AND C2.GROUP_NAME = 'C'
ORDER BY
    P1.KICKOFF, C1.RANKING;

------------ END

-- ********* 問16 (★★★　むず)
------- 対戦国のゴール数 （追加）
SELECT
    P1.KICKOFF,
    C1.NAME    AS MY_COUNTRY,
    C2.NAME    AS ENEMY_COUNTRY,
    C1.RANKING AS MY_RANKING,
    C2.RANKING AS ENEMY_RANKING,
    (
        SELECT
            COUNT(G1.ID)
        FROM
            GOALS G1
        WHERE
            P1.ID = G1.PAIRING_ID
    ) AS MY_GOALS,
    (
        SELECT
            COUNT(G2.ID)
        FROM
            GOALS    G2
            LEFT JOIN PAIRINGS P2
            ON P2.ID = G2.PAIRING_ID
        WHERE
            P2.MY_COUNTRY_ID = P1.ENEMY_COUNTRY_ID
            AND P2.ENEMY_COUNTRY_ID = P1.MY_COUNTRY_ID
    ) AS 追加カラムENEMY_GOALS
FROM
    PAIRINGS  P1
    LEFT JOIN COUNTRIES C1
    ON C1.ID = P1.MY_COUNTRY_ID
    LEFT JOIN COUNTRIES C2
    ON C2.ID = P1.ENEMY_COUNTRY_ID
WHERE
    C1.GROUP_NAME = 'C'
    AND C2.GROUP_NAME = 'C'
ORDER BY
    P1.KICKOFF, C1.RANKING;

------------ END

-- ********* 問15 ()
------- グループCの各対戦毎にゴール数を表示, ゴール数がゼロの場合も表示, 自国のゴール数は副問合せを用いて表示
SELECT
    P.KICKOFF,
    C.NAME,
    C2.NAME,
    C.RANKING,
    C2.RANKING,
    (
        SELECT
            COUNT(G.ID)
        FROM
            GOALS     G
        WHERE
            G.PAIRING_ID = P.ID
    )
FROM
    PAIRINGS  P
    JOIN COUNTRIES C
    ON P.MY_COUNTRY_ID = C.ID JOIN COUNTRIES C2
    ON P.ENEMY_COUNTRY_ID = C2.ID
ORDER BY
    P.KICKOFF ASC;

------------ END

-- ********* 問14 ()
------- グループCの各対戦毎にゴール数を表示
------- ゴール数がゼロの場合も表示してください。副問合せは使わずに、外部結合だけを使用
SELECT
    P.KICKOFF,
    C.NAME,
    C2.NAME,
    C.RANKING,
    C2.RANKING,
    COUNT(G.ID)
FROM
    PAIRINGS  P
    JOIN COUNTRIES C
    ON P.MY_COUNTRY_ID = C.ID JOIN COUNTRIES C2
    ON P.ENEMY_COUNTRY_ID = C2.ID
    JOIN GOALS G
    ON G.PAIRING_ID = P.MY_COUNTRY_ID
WHERE
    C.GROUP_NAME = 'C'
    AND C2.GROUP_NAME = 'C'
GROUP BY
    P.KICKOFF, C.NAME, C2.NAME, C.RANKING, C2.RANKING;

------------ END

-- ********* 問12 ()
------ 日本VSコロンビア戦の勝敗を表示
------ 日本のゴール数はpairings.id = 39、コロンビアのゴール数はparings.id = 103
SELECT
    C.NAME,
    COUNT(G.GOAL_TIME)
FROM
    GOALS     G
    LEFT JOIN PAIRINGS P
    ON P.ID = G.PAIRING_ID
    LEFT JOIN COUNTRIES C
    ON C.ID = P.MY_COUNTRY_ID
WHERE
    P.ID = '103'
    OR P.ID = '39'
GROUP BY
    C.NAME;

------------ END

-- ********* 問11 ()
------ 日本VSコロンビア戦（pairings.id = 103）でのコロンビアの得点のゴール時間を表示
SELECT
    G.GOAL_TIME
FROM
    GOALS G
WHERE
    G.PAIRING_ID = '103';

------------ END

-- ********* 問10 ()
------ 各グループごとの総得点数を表示して下さい。
SELECT
    C.GROUP_NAME,
    COUNT(G.ID)
FROM
    GOALS     G
    LEFT JOIN PAIRINGS P
    ON P.ID = G.PAIRING_ID
    LEFT JOIN COUNTRIES C
    ON P.MY_COUNTRY_ID = C.ID
WHERE
    P.KICKOFF BETWEEN '2014-06-13' AND '2014-6-27'
GROUP BY
    C.GROUP_NAME
ORDER BY
    C.GROUP_NAME ASC;

------------ END

-- ********* 問9 (年の計算)
------- ワールドカップ開催当時（2014-06-13）の年齢をプレイヤー毎に表示
-- 年だけ計算
SELECT
    EXTRACT(YEAR FROM DATE '2023-09-30') - EXTRACT(YEAR FROM DATE '2020-09-15');

------------ END

------
SELECT
    P.BIRTH,
    EXTRACT(YEAR FROM DATE '2014-06-13') - EXTRACT(YEAR FROM P.BIRTH) AS AGE,
    P.NAME,
    P.POSITION
FROM
    PLAYERS P
ORDER BY
    AGE DESC;

------------------------
------------------- END
------------------------

-- ********* 問 8 （副問い合わせ FROM , group by）
------- 各ポジションごとの総得点を表示

-------

SELECT
    PP.POSITION  AS ポジション,
    COUNT(PP.ID) AS ゴール数
FROM
    (
        SELECT
            P.POSITION,
            G.ID
        FROM
            PLAYERS P
            LEFT JOIN GOALS G
            ON G.PLAYER_ID = P.ID
    ) PP
GROUP BY
    PP.POSITION
ORDER BY
    ゴール数 DESC;

------------------------
------------------- END
------------------------

-- ********* 問 6 副問い合わせ
------- すべての選手を対象として選手ごとの得点ランキングを表示
SELECT
    P.NAME      AS 名前,
    P.POSITION  AS ポジション,
    P.CLUB      AS 所属クラブ,
    (
        SELECT
            COUNT(G.ID) AS ゴール数
        FROM
            GOALS   G
        WHERE
            G.PLAYER_ID = P.ID
    )
FROM
    PLAYERS P
ORDER BY
    ゴール数 DESC;

------------------------
------------------- END
------------------------