<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.nth.standard.mapper.MySQLMapper.MySqlServiceMapper">
    <select id="checkPage" resultType="int">
        SELECT count(1) as url_count FROM TB_CM_PROGRAM A WHERE PRG_URL = #{URL}
    </select>
	<select id="getPage" resultType="map">
    	SELECT
            A.PRG_CD,
            A.PRG_NM,
            A.PRG_URL,
            A.LOCAL_URL,
            LOWER(FN_CODE_NAME('DATABASE', A.DB_CD)) AS DB_NM,
            SCH_TERM,
            SCH_FR_CD,
            SCH_FR_DT,
            SCH_TO_CD,
            SCH_TO_DT,
            MAX(CASE WHEN C.AUTH_CD IS NULL THEN 0 ELSE 1 END) AS IS_AUTH,
            FN_MENU_LEVEL(A.PRG_CD, D.LANG_CD) AS MENU_LEVEL,
            MAX(CASE WHEN B.BTN1_YN = '1' AND COALESCE(A.BTN1_NM,'') != '' THEN COALESCE(NULLIF(D.BTN1_NM, ''), A.BTN1_NM) ELSE '' END) AS BTN1_NM,
            MAX(CASE WHEN B.BTN2_YN = '1' AND COALESCE(A.BTN2_NM,'') != '' THEN COALESCE(NULLIF(D.BTN2_NM, ''), A.BTN2_NM) ELSE '' END) AS BTN2_NM,
            MAX(CASE WHEN B.BTN3_YN = '1' AND COALESCE(A.BTN3_NM,'') != '' THEN COALESCE(NULLIF(D.BTN3_NM, ''), A.BTN3_NM) ELSE '' END) AS BTN3_NM,
            MAX(CASE WHEN B.BTN4_YN = '1' AND COALESCE(A.BTN4_NM,'') != '' THEN COALESCE(NULLIF(D.BTN4_NM, ''), A.BTN4_NM) ELSE '' END) AS BTN4_NM,
            MAX(CASE WHEN B.BTN5_YN = '1' AND COALESCE(A.BTN5_NM,'') != '' THEN COALESCE(NULLIF(D.BTN5_NM, ''), A.BTN5_NM) ELSE '' END) AS BTN5_NM,
            MAX(CASE WHEN B.BTN6_YN = '1' AND COALESCE(A.BTN6_NM,'') != '' THEN COALESCE(NULLIF(D.BTN6_NM, ''), A.BTN6_NM) ELSE '' END) AS BTN6_NM,
            MAX(CASE WHEN B.BTN7_YN = '1' AND COALESCE(A.BTN7_NM,'') != '' THEN COALESCE(NULLIF(D.BTN7_NM, ''), A.BTN7_NM) ELSE '' END) AS BTN7_NM,
            MAX(CASE WHEN B.BTN8_YN = '1' AND COALESCE(A.BTN8_NM,'') != '' THEN COALESCE(NULLIF(D.BTN8_NM, ''), A.BTN8_NM) ELSE '' END) AS BTN8_NM,
            MAX(CASE WHEN B.BTN9_YN = '1' AND COALESCE(A.BTN9_NM,'') != '' THEN COALESCE(NULLIF(D.BTN9_NM, ''), A.BTN9_NM) ELSE '' END) AS BTN9_NM,
            MAX(CASE WHEN B.BTN10_YN = '1' AND COALESCE(A.BTN10_NM,'') != '' THEN COALESCE(NULLIF(D.BTN10_NM, ''), A.BTN10_NM) ELSE '' END) AS BTN10_NM
        FROM    TB_CM_PROGRAM A
             LEFT JOIN TB_CM_AUTH_PROGRAM B
                 ON B.PRG_CD = A.PRG_CD
             LEFT JOIN TB_CM_USER_AUTH C
                 ON C.AUTH_CD = B.AUTH_CD
                 AND C.USER_ID = #{USER_ID}
             LEFT JOIN TB_CM_PROGRAM_LANG D
                 ON D.PRG_CD = A.PRG_CD
                and D.LANG_CD = #{LANG_CD}
        WHERE   A.PRG_URL = #{URL}
        AND     A.USE_YN = '1'
        GROUP BY A.PRG_CD,
                A.PRG_NM,
                A.PRG_URL,
                A.LOCAL_URL,
                A.SCH_TERM,
                A.SCH_FR_CD,
                A.SCH_FR_DT,
                A.SCH_TO_CD,
                A.SCH_TO_DT
    </select>
    <select id="getDataTable" resultType="map">
        SELECT * FROM TB_CM_USER WHERE USER_ID=#{userId}
    </select>
    <select id="runProcedure" resultType="map">
        SELECT * FROM TB_CM_USER WHERE USER_ID=#{userId}
    </select>
    <select id="testajax" resultType="map">
        SELECT LABEL_CD as id,
                LABEL_NM as name,
                LANG_CD as price
        FROM tb_cm_label
        WHERE 1=1
    </select>

</mapper>