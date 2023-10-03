------------ サブクエリをIN演算子と共に使う
SELECT
    *
FROM
    PAYMENT
WHERE
    CUSTOMER_ID IN (
        SELECT
            CUSTOMER_ID
        FROM
            CUSTOMER
        WHERE
            DATE_FORMAT(BIRTHDAY, '%m')=1
    ) LIMIT 15;

------------　副問い合わせ　02（WHERE 句で使う）
SELECT
    *
FROM
    BOOK ->
WHERE
    PRICE >= (
        SELECT
            AVG(PRICE)
        FROM
            BOOK
    ) -> LIMIT 10;

------------　副問い合わせ　01（WHERE 句で使う）
SELECT
    *
FROM
    PAYMENT
WHERE
    AMOUNT >=(
        SELECT
            AVG(AMOUNT)
        FROM
            PAYMENT
    );

------------ END