CREATE OR REPLACE PROCEDURE TOSSY_TEST_006 (
    GET_NUM_01 IN NUMBER, --- 500円
    GET_NUM_02 IN NUMBER, --- 100円
    GET_NUM_03 IN NUMBER, ---  50円
    EL_NUM IN NUMBER --- 合計金額
) IS
 --- 配列の定義（number型）
    TYPE TAB_N IS
        TABLE OF NUMBER INDEX BY PLS_INTEGER;
    NUM_TABLE TAB_N;
    ANS_NUM   NUMBER;
    TPM_NUM   NUMBER;
BEGIN
    NUM_TABLE(1) := GET_NUM_01; --- 500円
    NUM_TABLE(2) := GET_NUM_02; --- 100円
    NUM_TABLE(3) := GET_NUM_03; ---  50円
    NUM_TABLE(4) := EL_NUM; --- 総合計
    ANS_NUM := 0;
    FOR I IN 1..NUM_TABLE(1) LOOP --- 500円
        FOR J IN 1..NUM_TABLE(2) LOOP --- 100円
            FOR K IN 1..NUM_TABLE(3) LOOP --- 50円
                DBMS_OUTPUT.PUT_LINE(TO_CHAR(K));
                IF I * 500 + J * 100 + K * 50 = EL_NUM THEN
                    ANS_NUM := 1;
                END IF;
            END LOOP;
        END LOOP;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(ANS_NUM));
END;
 ------ プロシージャ　実行
 EXEC TOSSY_TEST_006(2, 2, 2, 100)