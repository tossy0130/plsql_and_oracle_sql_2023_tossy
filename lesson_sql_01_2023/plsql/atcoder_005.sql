CREATE OR REPLACE PROCEDURE TOSSY_TEST_005 (
    EL_NUM IN NUMBER,
    GET_NUM_01 IN NUMBER,
    GET_NUM_02 IN NUMBER,
    GET_NUM_03 IN NUMBER,
    GET_NUM_04 IN NUMBER
) IS
 /*
Atcoder 問題文 URL
HTTPS://ATCODER.JP/CONTESTS/ABC102/TASKS/ABC102_B
*/
 --- 配列の定義（char型）

 /* コメントアウト
    TYPE TAB IS
        TABLE OF VARCHAR2(20) INDEX BY PLS_INTEGER;
*/
 --- 配列の定義（number型）
    TYPE TAB_N IS
        TABLE OF NUMBER INDEX BY PLS_INTEGER;
 /*  コメントアウト
    TYPE TAB_NN IS
        TABLE OF NUMBER INDEX BY PLS_INTEGER;
*/
 ---    COL_TABLE TAB; --- char型配列
    NUM_TABLE TAB_N; --- number 配列
 ---    KKK_TABLE TAB_NN; --- number 配列
 --- 変数宣言
    ANS_NUM   NUMBER;
    TMP_NUM   NUMBER;
BEGIN
    NUM_TABLE (1) := GET_NUM_01;
    NUM_TABLE (2) := GET_NUM_02;
    NUM_TABLE (3) := GET_NUM_03;
    NUM_TABLE (4) := GET_NUM_04;
 /*  コメントアウト
	kkk_table(1) := GET_NUM_01;
    kkk_table(2) := GET_NUM_02;
    kkk_table(3) := GET_NUM_03;
    kkk_table(4) := GET_NUM_04;
*/
 --- 初期値セット
    ANS_NUM := ABS(NUM_TABLE(1)) - (NUM_TABLE(2));
    FOR I IN 1..EL_NUM - 1 LOOP
 --		DBMS_OUTPUT.PUT_LINE(TO_CHAR(I));
        FOR J IN 1..EL_NUM - 1 LOOP
 --- 同じ値はスキップする
            IF NUM_TABLE(I) = NUM_TABLE(J) THEN
                CONTINUE;
            ELSE
 --- 要素1 と 要素2 を引いて絶対値を ans_num に入れる
                TMP_NUM := ABS(NUM_TABLE(I) - NUM_TABLE(J));
            END IF;
            IF ANS_NUM < TMP_NUM THEN
                ANS_NUM := TMP_NUM;
            END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(ANS_NUM)
                             || 'ans');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(ANS_NUM)
                         || ':::ansans');
END;
/

--- プロシージャ実行
EXEC TOSSY_TEST_005(4, 1, 4, 6, 3);

--- 出力結果
--- 5