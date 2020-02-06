<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="AuthoritySettingService">
	<insert id="createPopupProgram">
	    <selectKey keyProperty="PRG_CD" resultType="String" order="BEFORE">
            SELECT COALESCE(LPAD(MAX(PRG_CD) + 1, 6, '0'),'000001') FROM TB_CM_PROGRAM
        </selectKey>
        INSERT INTO TB_CM_PROGRAM (
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
            NOTE,
            REG_ID,
            REG_DT
        )
        VALUES (
            #{PRG_CD},
            #{PRG_NM},
            #{DB_CD},
            #{USE_YN1},
            #{MENU_YN1},
            #{PRG_URL},
            #{LOCAL_URL},
            #{BTN1_NM},
            #{BTN2_NM},
            #{BTN3_NM},
            #{BTN4_NM},
            #{BTN5_NM},
            #{BTN6_NM},
            #{BTN7_NM},
            #{BTN8_NM},
            #{BTN9_NM},
            #{BTN10_NM},
            #{SCH_TERM},
            #{SCH_FR_CD},
            #{SCH_FR_DT},
            #{SCH_TO_CD},
            #{SCH_TO_DT},
            #{NOTE},
            #{u_userId},
            sysdate()
        )
    </insert>

    <update id="updateProgram">
        UPDATE TB_CM_PROGRAM
        SET
            PRG_NM = #{PRG_NM},
            DB_CD = #{DB_CD},
            USE_YN = #{USE_YN},
            MENU_YN = #{MENU_YN},
            PRG_URL = #{PRG_URL},
            LOCAL_URL = #{LOCAL_URL},
            BTN1_NM = #{BTN1_NM},
            BTN2_NM = #{BTN2_NM},
            BTN3_NM = #{BTN3_NM},
            BTN4_NM = #{BTN4_NM},
            BTN5_NM = #{BTN5_NM},
            BTN6_NM = #{BTN6_NM},
            BTN7_NM = #{BTN7_NM},
            BTN8_NM = #{BTN8_NM},
            BTN9_NM = #{BTN9_NM},
            BTN10_NM = #{BTN10_NM},
            SCH_TERM = NULLIF (#{SCH_TERM}, ''),
            SCH_FR_CD = #{SCH_FR_CD},
            SCH_FR_DT = #{SCH_FR_DT},
            SCH_TO_CD = #{SCH_TO_CD},
            SCH_TO_DT = #{SCH_TO_DT},
            NOTE = #{NOTE},
            UPD_ID = #{u_userId},
            UPD_DT = sysdate()
        WHERE PRG_CD = #{PRG_CD}
    </update>

    <update id="updateProgramAuthority">
        INSERT INTO TB_CM_AUTH_PROGRAM (
            AUTH_CD,
            PRG_CD,
            BTN1_YN,
            BTN2_YN,
            BTN3_YN,
            BTN4_YN,
            BTN5_YN,
            BTN6_YN,
            BTN7_YN,
            BTN8_YN,
            BTN9_YN,
            BTN10_YN,
            REG_ID,
            REG_DT
        )
        VALUES (
            #{AUTH_CD},
            #{PRG_CD},
            #{BTN1_YN},
            #{BTN2_YN},
            #{BTN3_YN},
            #{BTN4_YN},
            #{BTN5_YN},
            #{BTN6_YN},
            #{BTN7_YN},
            #{BTN8_YN},
            #{BTN9_YN},
            #{BTN10_YN},
            #{u_userId},
            sysdate()
        )
        ON DUPLICATE KEY
        UPDATE
            BTN1_YN = #{BTN1_YN},
            BTN2_YN = #{BTN2_YN},
            BTN3_YN = #{BTN3_YN},
            BTN4_YN = #{BTN4_YN},
            BTN5_YN = #{BTN5_YN},
            BTN6_YN = #{BTN6_YN},
            BTN7_YN = #{BTN7_YN},
            BTN8_YN = #{BTN8_YN},
            BTN9_YN = #{BTN9_YN},
            BTN10_YN = #{BTN10_YN},
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