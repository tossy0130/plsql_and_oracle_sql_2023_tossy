CREATE OR REPLACE FUNCTION T_TEST1(
    ID1 IN NUMBER
) RETURN VARCHAR2 IS
 --------------------------------
 ---------- 引数の IDのデータを返す
 --------------------------------
 --- 変数定義
    NAME1_1          TEST01_USERS.NAME%TYPE;
    EMAIL_1          TEST01_USERS.EMAIL%TYPE;
    R1               VARCHAR2(40);
 --- カーソル
    CURSOR CUR1 IS
        SELECT
            NAME,
            EMAIL
        FROM
            TEST01_USERS
        WHERE
            ID = ID1;
 --- レコード
    TEST01_USERS_REC CUR1%ROWTYPE;
BEGIN
    OPEN CUR1;
    FETCH CUR1 INTO TEST01_USERS_REC;
    CLOSE CUR1;
 -- カラムの値を挿入
    NAME1_1 := TEST01_USERS_REC.NAME;
    EMAIL_1 := TEST01_USERS_REC.EMAIL;
    R1 := NAME1_1
          || ','
          || EMAIL_1;
    RETURN R1;
END;