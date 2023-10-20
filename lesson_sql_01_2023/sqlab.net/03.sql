/*

書籍名に「宇宙」または「星」を含んでおり、かつ著者が女性の書籍名を取得してください。
出力項目はNAME(書籍名)です。

*/

SELECT
    BOOKS.NAME
FROM
    BOOKS
    JOIN BOOK_AUTHORS
    ON BOOK_AUTHORS.BOOK_ID = BOOKS.ID JOIN AUTHORS
    ON AUTHORS.ID = BOOK_AUTHORS.AUTHOR_ID
WHERE
    (BOOKS.NAME LIKE '%宇宙%'
    OR BOOKS.NAME LIKE '%星%')
    AND AUTHORS.GENDER = '女性';