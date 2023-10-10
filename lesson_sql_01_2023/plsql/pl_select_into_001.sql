------------ SELECT で 値取得テスト

CREATE OR REPLACE PROCEDURE TEST_TOSSY_SELECT_INTO_001(
    UKETUKE_NUM IN NUMBER, --- 受付番号
    YOYAKUBI_DATE IN DATE --- 予約日付（カラム予約時刻挿入用）
) IS
    GET_MUM NUMBER; --- 予約番号 取得用
BEGIN
    SELECT
        予約番号 INTO GET_MUM
    FROM
        火葬受付
    WHERE
        予約日付 = YOYAKUBI_DATE
        AND 受付番号 = UKETUKE_NUM;
 --- 出力テスト
    DBMS_OUTPUT.PUT_LINE('GET_MUM 出力:::'
                                    || GET_MUM);
 --- 例外処理
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('エラーが発生しました: '
                             || SQLERRM);
END;