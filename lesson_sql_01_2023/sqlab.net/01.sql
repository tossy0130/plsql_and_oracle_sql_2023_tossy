-------------------------------------------------------------------------------------
----------------- （下の問題を、副問い合わせ（サブクエリーで書いた例 ））
----------------- 店舗毎の書籍の売上(PRICE × FIGURE)を取得してください。また、店舗名は昇順に並び替えてください。
--------- 出力項目はNAME(店舗名)とSALES(売上)です。
SELECT
    STORES.NAME AS NAME,
    (
        SELECT
            SUM(BOOK_SALES.PRICE * BOOK_SALES.FIGURE)
        FROM
            BOOK_SALES
        WHERE
            BOOK_SALES.STORE_ID = STORES.ID
    ) AS SALES
FROM
    STORES
ORDER BY
    NAME;

----------------- 店舗毎の書籍の売上(PRICE × FIGURE)を取得してください。また、店舗名は昇順に並び替えてください。
--------- 出力項目はNAME(店舗名)とSALES(売上)です。
SELECT
    STORES.NAME                               AS NAME,
    SUM(BOOK_SALES.PRICE * BOOK_SALES.FIGURE) SALES
FROM
    STORES
    JOIN BOOK_SALES
    ON BOOK_SALES.STORE_ID = STORES.ID
GROUP BY
    NAME
ORDER BY
    NAME;

-------------------------------------------------------------------------------------


----------------- 在庫がない書籍名の一覧を取得してください。
--------- 出力項目はNAME(書籍名)です。
SELECT
    NAME
FROM
    BOOKS
    JOIN BOOK_SALES
    ON BOOK_SALES.BOOK_ID = BOOKS.ID
GROUP BY
    NAME
HAVING
    SUM(BOOK_SALES.STOCK) = 0;

----------------- 性別毎の著者数を取得してください。また、著者数は降順に並び替えてください。
--------- 出力項目はgender(性別)とnum(著者数)です。
SELECT
    GENDER,
    COUNT(ID) AS NUM
FROM
    AUTHORS
GROUP BY
    GENDER
ORDER BY
    NUM DESC;

--------------------- （結合）　書籍テーブルと著者テーブルを結合
--------- 出力項目はBOOK_NAME(書籍名)とAUTHOR_NAME(著者名)です。
SELECT
    BOOKS.NAME   AS BOOK_NAME,
    AUTHORS.NAME AS AUTHOR_NAME
FROM
    BOOK_AUTHORS
    INNER JOIN AUTHORS
    ON BOOK_AUTHORS.AUTHOR_ID = AUTHORS.ID
    INNER JOIN BOOKS
    ON BOOK_AUTHORS.BOOK_ID = BOOKS.ID;

---------------------（サブクエリ） 書籍名「時短レシピ100」「かもめ飛行」と発行年が同じ書籍一覧を取得
SELECT
    *
FROM
    BOOKS
WHERE
    RELEASE_YEAR = (
        SELECT
            RELEASE_YEAR
        FROM
            BOOKS
        WHERE
            NAME = '時短レシピ100'
    )
    OR RELEASE_YEAR = (
        SELECT
            RELEASE_YEAR
        FROM
            BOOKS
        WHERE
            NAME = 'かもめ飛行'
    );

--------------- （サブクエリ） 書籍名「コードと回路」より総ページ数の多い書籍一覧を取得
SELECT
    *
FROM
    BOOKS
WHERE
    TOTAL_PAGE > (
        SELECT
            TOTAL_PAGE
        FROM
            BOOKS
        WHERE
            NAME = 'コードと回路'
    );

--- 発行年別の書籍数を取得してください。また、書籍数は降順に並び替え、書籍数が2つ以上のデータを取得してください。
--- 出力項目はRELEASE_YEAR(発行年)とBOOKS_NUM(書籍数)です
SELECT
    RELEASE_YEAR,
    COUNT(*)     AS BOOKS_NUM
FROM
    BOOKS
GROUP BY
    RELEASE_YEAR
HAVING
    COUNT(*) >= 2
ORDER BY
    BOOKS_NUM DESC;

------------------- END


SELECT
    COUNT(*)
FROM
    定休日
WHERE
    適用開始日 = (
        SELECT
            MAX(適用開始日)
        FROM
            定休日
        WHERE
            適用開始日 <= '2000-04-01'
    )
    AND ((定休日区分 = 0
    AND 月日 = '')
    OR (定休日区分 = 1
    AND 曜日 = '')
    OR (定休日区分 = 2
    AND 六曜 = '友引'));

--- 発行年毎の書籍数を取得してください。また、書籍数は降順に並び替えてください。
--- 出力項目はRELEASE_YEAR(発行年)とBOOKS_NUM(書籍数)です。

------------------- END


SELECT
    RELEASE_YEAR,
    COUNT(ID)    AS BOOKS_NUM
FROM
    BOOKS
GROUP BY
    RELEASE_YEAR
ORDER BY
    BOOKS_NUM DESC;

------------------- END

--- 書籍一覧を発売年が新しい順に並び替えて取得
SELECT
    *
FROM
    BOOKS
ORDER BY
    RELEASE_YEAR DESC;

------------------- END

--- 書籍の総ページ数の最大値、最小値を取得
SELECT
    MAX(TOTAL_PAGE),
    MIN(TOTAL_PAGE)
FROM
    BOOKS;

------------------- END

--------
--- 平均
--------
SELECT
    AVG(TOTAL_PAGE)
FROM
    BOOKS;

------------------- END

----------
--- 合計数
---------
SELECT
    SUM(FIGURE)
FROM
    BOOK_SALES;

------------------- END

---------------------------------------
--- COUNT 女性の著者数を取得してください。
---------------------------------------
SELECT
    COUNT(ID)
FROM
    AUTHORS
WHERE
    AUTHORS.GENDER = '女性'
GROUP BY
    AUTHORS.GENDER;

------------------- END

----------
--- 合計値
----------
SELECT
    SUM(FIGURE)
FROM
    BOOK_SALES;

------------------- END