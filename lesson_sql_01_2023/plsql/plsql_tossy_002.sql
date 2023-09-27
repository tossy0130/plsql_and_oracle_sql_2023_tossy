CREATE OR REPLACE PROCEDURE TOSSY_TEST_004 (
    GET_NUM_01 IN NUMBER,
    GET_NUM_02 IN NUMBER,
    GET_NUM_03 IN NUMBER,
    GET_NUM_04 IN NUMBER
) IS

------ atcoder 問題
-- https://atcoder.jp/contests/abc081/tasks/abc081_b

 -- 変数の宣言
    V_INPUT_STR VARCHAR2(50); -- 数値を文字列に変換するための変数
    V_GET_NUM_01_L NUMBER;
 	V_GET_NUM_02 NUMBER;
	V_GET_NUM_03 NUMBER;
	V_GET_NUM_04 NUMBER;

	V_NUM_RESULT NUMBER;  --- 答え出力用  
BEGIN
	--- 変数へ値を代入
    V_GET_NUM_01_L := GET_NUM_01;
	
	V_GET_NUM_02 := GET_NUM_02;
	V_GET_NUM_03 := GET_NUM_03;
	V_GET_NUM_04 := GET_NUM_04;

	V_NUM_RESULT := 0;

    --- ループ開始
    FOR i IN 0..V_GET_NUM_01_L LOOP
		 IF mod(V_GET_NUM_02,2) = 0 THEN
        	DBMS_OUTPUT.PUT_LINE(TO_CHAR(V_GET_NUM_02));
            V_GET_NUM_02 := V_GET_NUM_02 / 2;
         ELSE
        	EXIT;
		 END IF;
        
		 IF mod(V_GET_NUM_03,2) = 0 THEN
        	DBMS_OUTPUT.PUT_LINE(TO_CHAR(V_GET_NUM_03));
            V_GET_NUM_03 := V_GET_NUM_03 / 2;
         ELSE
        	EXIT;
		 END IF;

		 IF mod(V_GET_NUM_04,2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(TO_CHAR(V_GET_NUM_04));
            V_GET_NUM_04 := V_GET_NUM_04 / 2;
         ELSE
        	EXIT;
		 END IF;

         V_NUM_RESULT := V_NUM_RESULT + 1;
    END LOOP;

		DBMS_OUTPUT.PUT_LINE('ANS:::' || TO_CHAR(V_num_result));

END;

----- Live SQL (oracle) での実行方法

----- 答え出力用
-- EXEC TOSSY_TEST_004(3, 8, 12, 40);