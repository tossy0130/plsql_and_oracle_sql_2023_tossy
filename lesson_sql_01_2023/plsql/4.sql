CREATE OR REPLACE PROCEDURE GET_TABLE_LIST_04(
    LOOP_NUM IN NUMBER
) IS
BEGIN

 ----------------------
 --- 多重ループ , ラベル  , start

 --- LOOP_NUM の値で抜ける
 ----------------------
    <<TT1>> ---ラベル
    FOR I IN 1..LOOP_NUM LOOP
        FOR J IN 1..20 LOOP

    		EXIT TT1 WHEN(I = LOOP_NUM); --- ループを抜ける
            DBMS_OUTPUT.PUT_LINE('i:::'
                                 || I
                                 || ','
                                 || 'j:::'
                                 || J);
        END LOOP;
    END LOOP;

----------------------
--- 多重ループ , ラベル  , END
----------------------


END;

------ 出力　試し
--- EXEC GET_TABLE_LIST_04(15);