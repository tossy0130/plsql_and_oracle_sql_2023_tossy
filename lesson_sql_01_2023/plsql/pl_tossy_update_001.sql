CREATE OR REPLACE PROCEDURE TEST_TOSSY_UPDATE_001(
    YOYAKU_NUM IN NUMBER, --- 受付番号
    YOYAKUBI_DATE_STR IN VARCHAR2 ---予約日付（カラム予約時刻挿入用）時間だけ使う
) YOYKUBI_DATE DATE; --- 日付格納
 YOYKUBI_TIME VARCHAR2(4); --- 時間を格納する
 YOYKUBI_TIME _ NUM NUMBER;
UPDATE_YOYKUBI_D A TE_STR UPDATE_YOYKUBI_DATE DATE;
 --------------------------------------------------
 --------------------- 火葬受付 , 火葬予約状況  更新用 TOSSY プロシージャ
 --------------------------------------------------
BEGIN
 --- 火葬受付 アップデート用
 --- char
    NUMBER
 -- YOYKUBI_TIME_NUM := TO_NUMBER(YOYKUBI_DATE, 'HH24MI');
    UPDATE_YOYKUBI_DATE_STR := TO_CHAR(YOYKUBI_DATE, 'YYYY-MM-DD ')
                               || '00:00:00';
    UPDATE_YOYKUBI_DATE := TO_DATE(UPDATE_YOYKUBI_DATE_STR, 'YYYY-MM-DD HH24:MI:SS');
    DBMS_OUTPUT.PUT_LINE('YOYKUBI_DATE 出力:::' DBMS_OUTPUT.PUT_LINE('YOYKUBI_TIME 出力:::'
                                                                   || YOYKUBI_TIME);
    DBMS_OUTPUT.PUT_LINE('UPDATE_YOYKUBI_DATE_STR 出力:::'
                         || UPDATE_YOYKUBI_DATE_STR);
    DBMS_OUTPUT.PUT_LINE('UPDATE_YOYKUBI_DATE
                         出力:::'
                         || UPDATE_YOYKUBI_DA TE);
    UPDATE 火葬受付 SET 予約時刻 = YOYKUBI_TIME
    AND 受付番号 = YOYAKU_NUM;
 ---UPDATE 火葬予約状況
    SET SET 予約状況 = 1
    AND 日付 = UPDATE_YOYKUBI_D
    AND 予約枠番号 = ( SET
        SELECT
            予約番号
            AND
            SELECT
            FROM
    );
    FROM 火葬受付 WHERE );
 --- コミット
    COMMIT;
 --- 例外処理
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('エラーが発生しました: '
                             || SQLERRM);
END;