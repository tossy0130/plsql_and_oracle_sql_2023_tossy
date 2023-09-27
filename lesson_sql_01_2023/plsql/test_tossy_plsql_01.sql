CREATE OR REPLACE PROCEDURE TOSSY_TEST_003 (
    GET_NUM IN NUMBER
) IS

------ atcoder 問題

-- A - Placing Marble
-- HTTPS://ATCODER.JP/CONTESTS/ABC081/TASKS/ABC081_A

 -- 変数の宣言
    V_INPUT_STR VARCHAR2(50); -- 数値を文字列に変換するための変数
    V_RESULT_01 VARCHAR2(50);
    V_RESULT_02 VARCHAR2(50);
    V_RESULT_03 VARCHAR2(50);

	V_num_result NUMBER;  --- 答え出力用  
BEGIN
    -- 数値を文字列に変換
    V_INPUT_STR := TO_CHAR(GET_NUM);
 -- SELECTの結果を変数に代入

	--- 文字を切り取って、変数へ格納  V_INPUT_STR , 1文字目
    SELECT
        SUBSTR(V_INPUT_STR, 1, 1) INTO V_RESULT_01
    FROM
        DUAL;
    
    --- 文字を切り取って、変数へ格納  V_INPUT_STR, 1文字目
    SELECT
        SUBSTR(V_INPUT_STR, 2, 1) INTO V_RESULT_02
    FROM
        DUAL;

    --- 文字を切り取って、変数へ格納  V_INPUT_STR, 1文字目
    SELECT
        SUBSTR(V_INPUT_STR, 3, 1) INTO V_RESULT_03
    FROM
        DUAL;

	--- 初期値セット  0
	V_num_result := 0;
	IF V_RESULT_01 = '1' THEN
        V_num_result := V_num_result + 1;
	END IF;

	IF V_RESULT_02 = '1' THEN
        V_num_result := V_num_result + 1;
    END IF;

	IF V_RESULT_03 = '1' THEN
        V_num_result := V_num_result + 1;
	END IF;
        
 -- v_resultの値を表示（DBMS_OUTPUT.PUT_LINEを使用）
    DBMS_OUTPUT.PUT_LINE('v_result_01:'
                                                                    || V_RESULT_01);
    DBMS_OUTPUT.PUT_LINE('v_result_02:'
                         || V_RESULT_02);
    DBMS_OUTPUT.PUT_LINE('v_result_03:'
                         || V_RESULT_03);

	--- TO_CHAR で整数から、文字列へ変更
	DBMS_OUTPUT.PUT_LINE('答え出力 :::' || TO_CHAR(V_num_result));
END;

----- Live SQL (oracle) での実行方法

----- 答え出力用
--- EXEC TOSSY_TEST_003(101)
--- EXEC TOSSY_TEST_003(000)

