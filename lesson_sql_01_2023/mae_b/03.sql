/*
BOOKSTORE データベースの SALES テーブルから、ブックIDと売上額、総売上額、
サブクエリを用いて総売上額に占める各本の売上額の割合を取得してください。

ブックIDは BOOK_ID カラム、 売上額は AMOUNT カラムに格納されています。
AS句を使って、ブックIDごとの売上額の合計には「売上額」というカラム名を付けてください。

全ての売上額の合計には「総売上額」、総売上額に占めるブックIDごとの売上額の割合には「割合」というカラム名をつけてください。
LIMIT句を付けて、上位10件のみ取得してください。
*/

SELECT
    BOOK_ID,
    SUM(AMOUNT) AS 売上額,
    (
        SELECT
            SUM(AMOUNT)
        FROM
            SALES
    ) AS 総売上額,
    SUM(AMOUNT) / (
        SELECT
            SUM(AMOUNT)
        FROM
            SALES
    ) AS 割合
FROM
    SALES
GROUP BY
    BOOK_ID LIMIT 10;

-------------------------------------------------------------

/*

1:
SELECT
    CUSTOMER_ID,
    : この部分は、結果のカラム（列）を指定しています。結果には「CUSTOMER_ID」が含まれます。これは各顧客を識別するための識別子です。 

2:
SUM(AMOUNT) AS 支払額,
    : この部分は、支払額の合計を計算し、その結果を「支払額」という名前のカラムとして返します。支払額は各顧客ごとに計算されます。 (

3:       
SELECT
    SUM(AMOUNT)
    FROM
    PAYMENT
) AS 総支払額,
: この部分は、全体の支払額を計算し、その結果を「総支払額」という名前のカラムとして返します。この部分はサブクエリを使用して、全ての支払いの合計を取得しています。この合計はすべての顧客の支払額の合計です。 

4:
SUM(AMOUNT) / (
        SELECT
            SUM(AMOUNT)
        FROM
            PAYMENT
    ) AS 割合: この部分は、各顧客の支払額を全体の支払額で割って、割合を計算します。割合は「割合」という名前のカラムとして返されます。これにより、各顧客の支払額が全体の支払額に占める割合が計算されます。

5:
FROM
    PAYMENT: この部分は、データを抽出する対象のテーブルを指定しています。この場合、「PAYMENT」というテーブルからデータを取得します。

6:
GROUP BY
    CUSTOMER_ID: この部分は、結果を「CUSTOMER_ID」でグループ化するための指示です。これにより、各顧客ごとにデータがグループ化され、その顧客の支払額と割合が計算されます。 このSQLクエリを実行すると、各顧客ごとに支払額、全体の支払額、および支払額の全体に対する割合が計算された結果セットが返されます。各行は異なる顧客に関する情報を含み、各顧客の支払額が全体の支払額に対してどのくらいの割合を占めるかが表示

*/

SELECT
    CUSTOMER_ID,
    SUM(AMOUNT) AS 支払額,
    (
        SELECT
            SUM(AMOUNT)
        FROM
            PAYMENT
    ) AS 総支払額,
    SUM(AMOUNT) / (
        SELECT
            SUM(AMOUNT)
        FROM
            PAYMENT
    ) AS 割合
FROM
    PAYMENT
GROUP BY
    CUSTOMER_ID;

----------------------------------------------------

/*
■ 問題

■ サブクエリをIN演算子と使う

bookstore データベースの sales テーブルから、サブクエリを用いて15ドルより高い本の販売のレコードを取得することを考えます。
本の値段は book テーブルの price カラムに格納されています。
また、ORDER BY句を用いてsales_idカラムの値が昇順になるように並べ替えて出力してください。
件数が多いためLIMIT句を付けて、上位10件のみ取得してください。

---------- 解答
*/

SELECT
    *
FROM
    SALES
WHERE
    BOOK_ID IN (
        SELECT
            BOOK_ID
        FROM
            BOOK
        WHERE
            PRICE > 15
    )
ORDER BY
    SALES_ID ASC LIMIT 10;