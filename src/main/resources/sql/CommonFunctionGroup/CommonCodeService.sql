<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CommonCodeService">
	<select id="getGroupCodeList" resultType="map">
    	SELECT
    	        P_CODE_CD,
    	        P_CODE_NM,
    	        MAX(SYS_YN) AS SYS_YN,
    	        MAX(USE_YN) AS USE_YN,
    	        MAX(REG_ID) AS REG_ID
        FROM    TB_CM_CODE
        WHERE   '1' = '1'
        <if test='S_P_CODE_NM != null and S_P_CODE_NM == "0"'>
            AND P_CODE_NM = #{S_P_CODE_NM}
        </if>
        <if test='S_CODE_NM != null and S_CODE_NM == "0"'>
            AND CODE_NM = #{S_CODE_NM}
        </if>
        <if test='S_USE_YN != null and S_USE_YN == "0"'>
            AND USE_YN = #{S_USE_YN}
        </if>

        GROUP BY P_CODE_CD, P_CODE_NM
        ORDER BY P_CODE_CD
    </select>

    <select id="getCodeDetailByGroupCode" resultType="map">
        SELECT
            P_CODE_CD,
            P_CODE_NM,
            CODE_CD,
            CODE_NM,
            USE_YN,
            ORD,
            REF1,
            REF2,
            REF3,
            REF4,
            REF5,
            REG_ID,
            REG_DT
        FROM TB_CM_CODE
        WHERE   P_CODE_CD = #{P_CODE_CD}
        ORDER BY CODE_CD
    </select>

    <update id="saveCodeList">
        INSERT INTO TB_CM_CODE (P_CODE_CD, P_CODE_NM, CODE_CD, CODE_NM, USE_YN, ORD, REF1, REF2, REF3, REF4, REF5, REG_ID, REG_DT)
            VALUES (#{P_CODE_CD}, #{P_CODE_NM}, #{CODE_CD}, #{CODE_NM}, #{USE_YN}, COALESCE(#{ORD}, 1), #{REF1}, #{REF2}, #{REF3}, #{REF4}, #{REF5}, #{u_userId}, sysdate())
        ON DUPLICATE KEY
        UPDATE
            P_CODE_NM = #{P_CODE_NM},
            CODE_NM = #{CODE_NM},
            USE_YN = #{USE_YN},
            ORD = #{ORD},
            REF1 = #{REF1},
            REF2 = #{REF2},
            REF3 = #{REF3},
            REF4 = #{REF4},
            REF5 = #{REF5},
            UPD_ID = #{u_userId},
            REG_DT = sysdate()
    </update>

    <select id="GroupCodeList" resultType="map">
        SELECT
            A.CODE_CD AS CODE,
            B.CODE_NM AS NAME
        FROM TB_CM_CODE A
        INNER JOIN TB_CM_CODE_LANG B
        ON B.P_CODE_CD = A.P_CODE_CD
        AND B.CODE_CD = A.CODE_CD
        AND B.LANG_CD = #{u_langCd}
        WHERE   A.USE_YN = '1'
        <if test='param1 != null and param1 == ""'>
            AND A.P_CODE_CD = #{param1}
        </if>
        <if test='param2 != null and param2 == ""'>
            AND A.REF1 = #{param2}
        </if>
        <if test='param3 != null and param3 == ""'>
            AND A.REF2 = #{param3}
        </if>
        <if test='param4 != null and param4 == ""'>
            AND A.REF3 = #{param4}
        </if>
        <if test='param5 != null and param5 == ""'>
            AND A.REF4 = #{param5}
        </if>
        <if test='param6 != null and param6 == ""'>
            AND A.REF5 = #{param6}
        </if>
        ORDER BY A.ORD
    </select>

    <select id="getLangList" resultType="map">
        SELECT
            CODE_CD AS CODE,
            CODE_NM AS NAME
        FROM TB_CM_CODE
        WHERE   P_CODE_CD = 'LANG'
        AND     USE_YN = '1'
        ORDER BY CODE_CD
    </select>

    <insert id="saveLangCodeList">
        INSERT INTO TB_CM_CODE_LANG (LANG_CD, P_CODE_CD, CODE_CD, CODE_NM, REG_ID, REG_DT)
        SELECT
            B.CODE_CD AS LANG_CD,
            A.P_CODE_CD,
            A.CODE_CD,
            A.CODE_NM,
            #{u_userId},
            sysdate()
        FROM TB_CM_CODE A
        CROSS JOIN TB_CM_CODE B
            ON B.P_CODE_CD = 'LANG'
        LEFT JOIN TB_CM_CODE_LANG C
            ON C.P_CODE_CD = A.P_CODE_CD
            AND C.CODE_CD = A.CODE_CD
        WHERE A.P_CODE_CD = #{P_CODE_CD}
        AND C.LANG_CD IS NULL
    </insert>
</mapper>