<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AuthorityService">
	<select id="getAuthList" resultType="map">
    	SELECT
    	        AUTH_CD,
    	        AUTH_NM,
    	        NOTE,
    	        USE_YN,
    	        REG_ID
        FROM    TB_CM_AUTH
        WHERE   1 = 1
        <if test='S_AUTH_CD != null and S_AUTH_CD == "0"'>
            AND AUTH_CD = #{S_AUTH_CD}
        </if>
        <if test='S_MSG_NM != null and S_MSG_NM == "0"'>
            AND AUTH_NM = #{S_AUTH_NM}
        </if>
        <if test='S_USE_YN != null and S_USE_YN == "0"'>
            AND USE_YN = #{S_USE_YN}
        </if>

        GROUP BY AUTH_CD
    </select>

    <select id="getUserByAuthCode" resultType="map">
        SELECT
            A.AUTH_CD,
            B.AUTH_NM,
            A.USER_ID,
            C.USER_NM,
            A.USE_YN,
            A.REG_ID,
            A.REG_DT
        FROM TB_CM_USER_AUTH A
        LEFT JOIN TB_CM_AUTH B
            ON B.AUTH_CD = A.AUTH_CD
        LEFT JOIN TB_CM_USER C
            ON C.USER_ID = A.USER_ID
        WHERE   A.AUTH_CD = #{AUTH_CD}
    </select>

    <update id="saveAuthGroup">
        INSERT INTO TB_CM_AUTH (AUTH_CD, AUTH_NM, NOTE, USE_YN, REG_ID, REG_DT)
            VALUES (#{AUTH_CD}, #{AUTH_NM}, #{NOTE}, #{USE_YN}, #{u_userId}, sysdate())
        ON DUPLICATE KEY
        UPDATE
            AUTH_NM = #{AUTH_NM},
            NOTE = #{NOTE},
            USE_YN = #{USE_YN},
            UPD_ID = #{u_userId},
            REG_DT = sysdate()
    </update>

    <update id="saveUserAuth">
        INSERT INTO TB_CM_USER_AUTH (AUTH_CD, USER_ID, USE_YN, REG_ID, REG_DT)
            VALUES (#{AUTH_CD}, #{USER_ID}, #{USE_YN}, #{u_userId}, sysdate())
        ON DUPLICATE KEY
        UPDATE
            USE_YN = #{USE_YN},
            UPD_ID = #{u_userId},
            REG_DT = sysdate()
    </update>
    <select id="getProgramByCode" resultType="map">
    	SELECT
            PRG_CD,
            PRG_NM,
            DB_CD,
            USE_YN,
            MENU_YN,
            PRG_URL,
            LOCAL_URL,
            BTN1_NM,
            BTN2_NM,
            BTN3_NM,
            BTN4_NM,
            BTN5_NM,
            BTN6_NM,
            BTN7_NM,
            BTN8_NM,
            BTN9_NM,
            BTN10_NM,
            SCH_TERM,
            SCH_FR_CD,
            SCH_FR_DT,
            SCH_TO_CD,
            SCH_TO_DT,
            NOTE
        FROM    TB_CM_PROGRAM
        WHERE   PRG_CD = #{PRG_CD}
    </select>
    <select id="getProgramLangByCode" resultType="map">
    	SELECT
            PRG_CD,
            PRG_NM,
            LANG_CD,
            FN_CODE_NAME_LANG('LANG', LANG_CD, #{u_langCd}) AS LANG_NM,
            BTN1_NM,
            BTN2_NM,
            BTN3_NM,
            BTN4_NM,
            BTN5_NM,
            BTN6_NM,
            BTN7_NM,
            BTN8_NM,
            BTN9_NM,
            BTN10_NM
        FROM    TB_CM_PROGRAM_LANG
        WHERE   PRG_CD = #{PRG_CD}
    </select>
    <select id="getProgramAuthByCode" resultType="map">
    	SELECT
            A.AUTH_CD,
            A.PRG_CD,
            A.BTN1_YN,
            A.BTN2_YN,
            A.BTN3_YN,
            A.BTN4_YN,
            A.BTN5_YN,
            A.BTN6_YN,
            A.BTN7_YN,
            A.BTN8_YN,
            A.BTN9_YN,
            A.BTN10_YN,
            B.AUTH_NM
        FROM    TB_CM_AUTH_PROGRAM A
        inner join TB_CM_AUTH B
        on B.AUTH_CD = A.AUTH_CD
        WHERE   A.PRG_CD = #{PRG_CD}
    </select>
</mapper>