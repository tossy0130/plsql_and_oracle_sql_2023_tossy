CREATE OR REPLACE PROCEDURE Z0204001 (
    P_YDATE IN DATE, -- 予約日付
    T_UKETUKE_NUM IN NUMBER, --- ★★★ 追加 受付番号
    P_RSLT OUT NUMBER, -- ステータス(0:正常終了 99:エラー)
    P_SQLCODE OUT NUMBER, -- エラーコード
    P_SQLERRM OUT VARCHAR2 -- エラー内容
)
 /*******************************************************************************


23_1010 夏目智鉄：前橋WEB用に機能追加

*******************************************************************************/
 /*======================================
  変数宣言
======================================*/ IS
    V_CNT            NUMBER; --レコード数
    V_CDATE          DATE; --作成日
    V_WKNO           NUMBER; --予約枠番号
    V_REKY           NUMBER; --霊きゅう車有無
    V_STAT           NUMBER; --状況
    V_UKETUKE_NUM    NUMBER; -- ★★★ 追加 受付番号
    GET_YOYAKU_NUM   NUMBER; -- ★★★ 予約番号 取得用
    YOYAKU_J         NUMBER; -- ★★★ 予約状況　インサート用
    CHAR_DATE_YOYAKU VARCHAR2(10);
    DATE_CHAR        VARCHAR2(10);
 --ｶｰｿﾙ宣言
    CURSOR C_WK1(V_YDATE DATE) IS
        SELECT
            名称.KEY2,
            全枠.予約枠数                 AS 全枠数,
            NVL(日別車枠.予約枠数, 車枠.予約枠数) AS 車枠数,
            NVL(日別全枠.予約枠数, 全枠.予約枠数) AS 日別全枠数
        FROM
            (
                SELECT
                    *
                FROM
                    予約枠名称
                WHERE
                    KEY1 = 0
                    AND 適用開始日 = (
                        SELECT
                            MAX(適用開始日)
                        FROM
                            予約枠名称
                        WHERE
                            適用開始日 <= V_YDATE
                    )
            ) 名称,
            (
                SELECT
                    *
                FROM
                    予約枠
                WHERE
                    KEY1 = 0
                    AND KEY3 = 0
            ) 全枠,
            (
                SELECT
                    *
                FROM
                    予約枠
                WHERE
                    KEY1 = 0
                    AND KEY3 = 2
            ) 車枠,
            (
                SELECT
                    *
                FROM
                    日別予約枠
                WHERE
                    KEY1 = 0
                    AND KEY3 = 0
                    AND 日付 = V_YDATE
            ) 日別全枠,
            (
                SELECT
                    *
                FROM
                    日別予約枠
                WHERE
                    KEY1 = 0
                    AND KEY3 = 2
                    AND 日付 = V_YDATE
            ) 日別車枠
        WHERE
            名称.適用開始日 = 全枠.適用開始日
            AND 名称.KEY2 = 全枠.KEY2
            AND 名称.適用開始日 = 車枠.適用開始日
            AND 名称.KEY2 = 車枠.KEY2
            AND 名称.KEY2 = 日別全枠.KEY2(+)
            AND 名称.KEY2 = 日別車枠.KEY2(+)
        ORDER BY
            名称.予約枠時刻, 名称.KEY2;
 --ﾚｺｰﾄﾞ宣言
    R_WK1            C_WK1%ROWTYPE;
 ----------------------　★★★ 追加 23_1010
    CURSOR P_CURSOR IS
        SELECT
            *
        FROM
            火葬予約状況
        WHERE
            日付 = P_YDATE;
    CURSOR TT_CURSOR IS
        SELECT
            *
        FROM
            火葬受付
        WHERE
            予約日付 = TO_CHAR(P_YDATE);
 --- レコード
    K_RECORD         P_CURSOR%ROWTYPE; --- 火葬予約状況
    KS_RECORD        TT_CURSOR%ROWTYPE; --- 火葬受付
 ----------------------　★★★ 追加 23_1010 END

 /*=======================================
  本体
=======================================*/
BEGIN
 --初期処理
    P_RSLT := 0;
    P_SQLCODE := 0;
    P_SQLERRM := NULL;
 ----------------------------　★★★ 追加 23_1010
    FOR KS_RECORD IN TT_CURSOR LOOP
        DBMS_OUTPUT.PUT_LINE('予約番号 IF :::'
                             || KS_RECORD.予約番号);
    END LOOP;
 ----------------------------　★★★ 追加 23_1010
 --- IN date hcarへ型変更
    CHAR_DATE_YOYAKU := TO_CHAR(P_YDATE, 'YYYY-MM-DD');
    DBMS_OUTPUT.PUT_LINE('IN 01:::'
                         || CHAR_DATE_YOYAKU);
    DBMS_OUTPUT.PUT_LINE('IN 02:::'
                         || T_UKETUKE_NUM);
 --- 予約時刻 取得
    SELECT
        予約番号 INTO GET_YOYAKU_NUM
    FROM
        火葬受付
    WHERE
        予約日付 = CHAR_DATE_YOYAKU
        AND 受付番号 = T_UKETUKE_NUM;
 ----------------------　★★★ 追加 23_1010 END
 --作成済みチェック
    SELECT
        COUNT(*) INTO V_CNT
    FROM
        火葬予約状況
    WHERE
        日付 = P_YDATE;
    IF V_CNT > 0 THEN
        RETURN;
    END IF;
 --日付の取得
    SELECT
        SYSDATE INTO V_CDATE
    FROM
        DUAL;
 --火葬予約状況作成
    V_WKNO := 1;
    FOR R_WK1 IN C_WK1(P_YDATE) LOOP
        FOR II IN 1..R_WK1.全枠数 LOOP
            IF II <= R_WK1.車枠数 THEN
                V_REKY := 1;
            ELSE
                V_REKY := 0;
            END IF;
            IF II > R_WK1.日別全枠数 THEN
                V_STAT := 9;
            ELSE
                V_STAT := 0;
            END IF;
 ----------------------------　★★★ 追加 23_1010
            IF V_WKNO = GET_YOYAKU_NUM THEN
                V_STAT := 1;
            ELSE
                V_STAT := 0;
            END IF;
 ----------------------------　★★★ 追加
            INSERT INTO 火葬予約状況(
                日付,
                予約枠番号,
                予約枠名称番号,
                霊きゅう車枠,
                予約番号,
                予約状況,
                作成日時,
                更新日時,
                更新SEQ
            ) VALUES(
                P_YDATE,
                V_WKNO,
                R_WK1.KEY2,
                V_REKY,
                0,
                V_STAT --- 変更 23_1010
,
                V_CDATE,
                V_CDATE,
                更新SEQ.NEXTVAL
            );
            V_WKNO := V_WKNO + 1;
        END LOOP;
    END LOOP;
 /*======================================
 例外処理
======================================*/
EXCEPTION
    WHEN OTHERS THEN
        P_RSLT := 99;
        P_SQLCODE := SQLCODE;
        P_SQLERRM := SQLERRM;
END;