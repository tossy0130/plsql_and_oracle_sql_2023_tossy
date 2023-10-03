CREATE OR REPLACE PROCEDURE GET_TABLE_LIST_02(
    R_STR OUT VARCHAR2
) IS
 --- カーソルセット
    CURSOR P_CURSOR IS
        SELECT
            *
        FROM
            TEST01_USERS;
 --- レコード定義
    TEST_LP P_CURSOR%ROWTYPE;
BEGIN
 --- レコードにセット
    FOR TEST_LP IN P_CURSOR LOOP
        R_STR := TEST_LP.ID
                         || ','
                         || TEST_LP.NAME
                         || ','
                         || TEST_LP.EMAIL;
        DBMS_OUTPUT.PUT_LINE('GET_TABLE_LIST_02::'
                             || R_STR);
    END LOOP;
END;