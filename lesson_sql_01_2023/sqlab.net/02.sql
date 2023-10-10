----------------- 書籍名と価格、消費税の一覧を取得してください。
--------- 出力項目はNAME(書籍名)とPRICE(価格)、TAX(消費税)です。
SELECT
    BOOKS.NAME,
    BOOK_SALES.PRICE,
    (BOOK_SALES.PRICE * 1.1 - BOOK_SALES.PRICE) AS TAX
FROM
    BOOKS
    JOIN BOOK_SALES
    ON BOOKS.ID = BOOK_SALES.BOOK_ID;