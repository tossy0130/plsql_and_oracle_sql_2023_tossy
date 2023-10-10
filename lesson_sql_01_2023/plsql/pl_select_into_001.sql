CREATE OR REPLACE PROCEDURE TEST_TOSSY_SELECT_INTO_001(
    UKETUKE_NUM IN NUMBER, --- 受付番号
    YOYAKUBI_DATE_IN IN DATE --- 予約日付（カラム予約時刻挿入用）
)
 -- UKETUKE_NUM IN NUMBER, --- 受付番号
 -- YOYAKUBI_DATE_IN IN DATE --- 予約日付（カラム予約時刻挿入用）
 IS
    GET_YOYAKU_NUM          NUMBER; --- 予約番号 取得用
    YOYKUBI_DATE            DATE; --- 日付格納
    UPDATE_YOYKUBI_DATE_STR VARCHAR2(100); --- 日付格納用
    GET_YOYAKU_TIME         VARCHAR2(10); --- 予約時刻　挿入用
    L_CONTROL               火葬受付%ROWTYPE;
    LL_CONTROL              火葬予約状況%ROWTYPE;
BEGIN
 -- YOYKUBI_DATE := TO_DATE(YOYAKUBI_DATE_IN, 'YYYY-MM-DD HH24:MI:SS');
    YOYKUBI_DATE := YOYAKUBI_DATE_IN;
    UPDATE_YOYKUBI_DATE_STR := TO_CHAR(YOYKUBI_DATE, 'YYYY-MM-DD ')
                               || '00:00:00';
 --- 予約時刻 取得
    SELECT
        予約番号 INTO GET_YOYAKU_NUM
    FROM
        火葬受付
    WHERE
        予約日付 = UPDATE_YOYKUBI_DATE_STR
        AND 受付番号 = UKETUKE_NUM;
    CASE
        WHEN GET_YOYAKU_NUM IN (1, 2, 3) THEN
            GET_YOYAKU_TIME := '1000';
        WHEN GET_YOYAKU_NUM IN (4, 5, 6) THEN
            GET_YOYAKU_TIME := '1100';
        WHEN GET_YOYAKU_NUM IN (7, 8, 9) THEN
            GET_YOYAKU_TIME := '1300';
        WHEN GET_YOYAKU_NUM IN (10, 11, 12) THEN
            GET_YOYAKU_TIME := '1400';
        WHEN GET_YOYAKU_NUM IN (13, 14) THEN
            GET_YOYAKU_TIME := '1500';
        WHEN GET_YOYAKU_NUM IN (15, 16) THEN
            GET_YOYAKU_TIME := '1600';
        WHEN GET_YOYAKU_NUM IN (17, 18) THEN
            GET_YOYAKU_TIME := '1700';
        ELSE
            GET_YOYAKU_TIME := '0000';
    END CASE;
 --- UPDATE文を使用して、火葬受付テーブルの予約時刻カラムを更新
    UPDATE 火葬受付
    SET
        予約時刻 = GET_YOYAKU_TIME
    WHERE
        予約日付 = UPDATE_YOYKUBI_DATE_STR
        AND 受付番号 = UKETUKE_NUM;
 --- 火葬受付 確認
    SELECT
        * INTO L_CONTROL
    FROM
        火葬受付
    WHERE
        予約日付 = UPDATE_YOYKUBI_DATE_STR
        AND 受付番号 = UKETUKE_NUM;
 ---  YYYY-MM-DD 00-00-00 で 抽出
    UPDATE 火葬予約状況
    SET
        予約状況 = 1
    WHERE
        日付 = UPDATE_YOYKUBI_DATE_STR
        AND 予約枠番号 = (
            SELECT
                予約番号
            FROM
                火葬受付
            WHERE
                受付番号 = UKETUKE_NUM
        );
    SELECT
        * INTO LL_CONTROL
    FROM
        火葬予約状況
    WHERE
        日付 = UPDATE_YOYKUBI_DATE_STR
        AND 予約枠番号 = GET_YOYAKU_NUM;
 --- コミット
    COMMIT;
 --- 出力テスト
 --  DBMS_OUTPUT.PUT_LINE('GET_MUM 出力:::' || GET_NUM);
    DBMS_OUTPUT.PUT_LINE('GET_MUM 出力:::'
                                                                                           || GET_YOYAKU_NUM);
    DBMS_OUTPUT.PUT_LINE('GET_YOYYAKU_TIME 出力:::'
                         || GET_YOYAKU_TIME);
    DBMS_OUTPUT.PUT_LINE('SELECT 予約時刻 出力:::'
                         || L_CONTROL.予約時刻);
    DBMS_OUTPUT.PUT_LINE('SELECT 予約状況 出力:::'
                         || LL_CONTROL.予約状況);
 --   COMMIT;
 --- 例外処理
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('エラーが発生しました: '
                             || SQLERRM);
END;