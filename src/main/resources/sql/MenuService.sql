<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.nth.standard.mapper.MySQLMapper.MenuServiceMapper">

	<select id="getPermittedRolesByUrl" resultType="string">
    	SELECT
    	        B.AUTH_CD
        FROM    TB_CM_PROGRAM A
                INNER JOIN TB_CM_AUTH_PROGRAM B
                    ON B.PRG_CD = A.PRG_CD
                INNER JOIN TB_CM_USER_AUTH C
                    ON C.AUTH_CD = B.AUTH_CD
        WHERE   A.PRG_URL = #{PROG_URL}
        AND     C.USER_ID = #{userId}
    </select>

    <select id="getUserMenuList" resultType="map">
        WITH RECURSIVE TMP_MENU_PROGRAM_TREE AS (
        	WITH RECURSIVE TMP_MENU AS (
        		SELECT
        		    MENU_CD,
                    P_MENU_CD,
                    LVL
        		FROM   TB_CM_MENU
        		WHERE  MENU_CD IN (SELECT PRG_CD FROM VW_AUTH_MENU_USER WHERE USER_ID = #{userId} AND MENU_YN = '1')
        		UNION ALL
        		SELECT P.MENU_CD,
        				P.P_MENU_CD,
        				P.LVL
        		FROM   TB_CM_MENU P
        		INNER  JOIN TMP_MENU
        		ON     TMP_MENU.P_MENU_CD = P.MENU_CD
        	),
        	TMP_MENU_PROGRAM AS (
                SELECT
                    MENU_CD,
                    P_MENU_CD,
                    LVL,
                    B.PRG_CD,
                    COALESCE(C.PRG_NM, B.PRG_NM) AS PRG_NM,
                    CONCAT(LOWER(FN_CODE_NAME('DATABASE', B.DB_CD)),'/', NULLIF(B.PRG_URL,'')) AS PRG_URL
        		FROM (SELECT DISTINCT * FROM TMP_MENU) A
        		INNER  JOIN TB_CM_PROGRAM B
        		ON     B.PRG_CD = A.MENU_CD
        		LEFT   OUTER JOIN TB_CM_PROGRAM_LANG C
        		ON     C.PRG_CD = B.PRG_CD
        		AND    C.LANG_CD = #{LANG_CD}
        	)
        	SELECT
        		MENU_CD,
        		P_MENU_CD,
        		LVL,
        		CAST(LPAD(LVL, 2, 0) AS CHAR(50)) AS PRG_NO,
        		1 AS PROG_LVL,
        		PRG_CD,
        		PRG_NM,
        		PRG_URL
        	FROM   TMP_MENU_PROGRAM
        	WHERE  NULLIF(P_MENU_CD,'') IS NULL
        	UNION ALL
        	SELECT
        		P.MENU_CD,
        		P.P_MENU_CD,
        		P.LVL,
        		CONCAT(PRG_NO, CAST(LPAD(P.LVL, 2, 0) AS CHAR(50))) AS PRG_NO,
        		1 + PROG_LVL AS PROG_LVL,
        		P.PRG_CD,
        		P.PRG_NM,
        		P.PRG_URL
        	FROM   TMP_MENU_PROGRAM P
        	INNER  JOIN TMP_MENU_PROGRAM_TREE CTE
        	ON     P.P_MENU_CD = CTE.MENU_CD
        )
        SELECT * FROM TMP_MENU_PROGRAM_TREE ORDER BY PRG_NO
    </select>

</mapper>