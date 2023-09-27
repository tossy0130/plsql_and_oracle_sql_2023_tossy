CREATE OR REPLACE TRIGGER ORDERINSERTTRIGGER AFTER
    INSERT ON TBL_ORDER FOR EACH ROW
DECLARE
 -- TBL_ORDER のデータは :NEW に入っているので、
 -- TBL_ORDER 以外のテーブルから取得する顧客名、商品名、商品単価を変数にする
    V_CUSTOMER_NAME TBL_CUSTOMER.CUSTOMER_NAME%TYPE;
    V_GOODS_NAME    TBL_GOODS.GOODS_NAME%TYPE;
    V_GOODS_PRICE   TBL_GOODS.GOODS_PRICE%TYPE;
BEGIN
    IF INSERTING THEN
 -- TBL_CUSTOMER の CUSTOMER_NAME を取得して、
 -- 変数 V_CUSTOMER_NAME に入れる
        SELECT
            CUSTOMER_NAME INTO V_CUSTOMER_NAME
        FROM
            TBL_CUSTOMER
        WHERE
            CUSTOMER_CODE = :NEW.CUSTOMER_CODE;
 -- TBL_GOODS の GOODS＿NAME と GOODS_PRICE を取得して、
 -- 変数 V_GOODS_NAME と、変数 V_GOODS_PRICE に入れる
        SELECT
            GOODS_NAME,
            GOODS_PRICE INTO V_GOODS_NAME,
            V_GOODS_PRICE
        FROM
            TBL_GOODS
        WHERE
            GOODS_CODE = :NEW.GOODS_CODE;
 -- TBL_ORDER_SEARCH に INSERT 実行
        INSERT INTO TBL_ORDER_SEARCH (
            ORDER_CODE,
            CUSTOMER_NAME,
            GOODS_NAME,
            GOODS_PRICE,
            ORDER_AMT,
            ORDER_PRICE
        ) VALUES (
            :NEW.ORDER_CODE,
 -- NVL2は oracle の関数, NVL2(値 1, 値 2, 値 3)
 -- 値 1が、NULLだったら 値 3が入る
 -- 値1が、NULLじゃなかったら、値 2が入る。
            NVL2(V_CUSTOMER_NAME, V_CUSTOMER_NAME, 'ゲストユーザ'),
            V_GOODS_NAME,
            V_GOODS_PRICE,
            :NEW.ORDER_AMT,
            :NEW.ORDER_AMT * V_GOODS_PRICE
        );
    END IF;
END;