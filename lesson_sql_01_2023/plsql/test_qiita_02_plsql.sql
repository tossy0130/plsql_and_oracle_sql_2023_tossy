CREATE OR REPLACE PROCEDURE FIZZ_BUZZ_TEST(
    ENDNUM IN NUMBER
) IS
BEGIN
    FOR I IN 1..ENDNUM LOOP
        IF (MOD(I, 3) = 0) AND (MOD(I, 5) = 0) THEN
            DBMS_OUTPUT.PUT_LINE('Fizz Buzz:::'
                                 || I);
        ELSIF(MOD(I, 3) = 0) THEN
            DBMS_OUTPUT.PUT_LINE('Fizz:::'
                                 || I);
        ELSIF(MOD(I, 5) = 0) THEN
            DBMS_OUTPUT.PUT_LINE('Buzz:::'
                                 || I);
        ELSE
            DBMS_OUTPUT.PUT_LINE('warikirenai:::'
                                 || I);
        END IF;
    END LOOP;
END;