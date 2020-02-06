<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ComboBoxService">
	<select id="getCommonCodeList" resultType="map">
        SELECT
            A.CODE_CD AS CODE,
            B.CODE_NM AS NAME
        FROM TB_CM_CODE A
        INNER JOIN TB_CM_CODE_LANG B
        ON B.P_CODE_CD = A.P_CODE_CD
        AND B.CODE_CD = A.CODE_CD
        AND B.LANG_CD = #{u_langCd}
        WHERE   A.USE_YN = '1'
        <if test='param1 != null and param1 != ""'>
            AND A.P_CODE_CD = #{param1}
        </if>
        <if test='param2 != null and param2 != ""'>
            AND A.REF1 = #{param2}
        </if>
        <if test='param3 != null and param3 != ""'>
            AND A.REF2 = #{param3}
        </if>
        <if test='param4 != null and param4 != ""'>
            AND A.REF3 = #{param4}
        </if>
        <if test='param5 != null and param5 != ""'>
            AND A.REF4 = #{param5}
        </if>
        <if test='param6 != null and param6 != ""'>
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

    <select id="getProgramList" resultType="map">
        SELECT
            A.PRG_CD AS CODE,
            COALESCE(B.PRG_NM, A.PRG_NM) AS NAME
        FROM    TB_CM_PROGRAM A
        LEFT JOIN TB_CM_PROGRAM_LANG B
            ON B.PRG_CD = A.PRG_CD
            AND B.LANG_CD = #{u_langCd}
        WHERE   COALESCE(A.PRG_URL, '') != ''
        ORDER BY A.PRG_CD
    </select>

</mapper>