-- ********* 問9 (年の計算)
------- ワールドカップ開催当時（2014-06-13）の年齢をプレイヤー毎に表示
-- 年だけ計算
SELECT
    EXTRACT(YEAR FROM DATE '2023-09-30') - EXTRACT(YEAR FROM DATE '2020-09-15');

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