<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CodeLangService">
	<select id="getLangCodeList" resultType="map">
    	SELECT distinct
                P_CODE_CD,
                P_CODE_NM,
    	        CODE_CD,
    	        CODE_NM
        FROM    tb_cm_code
        WHERE   SYS_YN = '0'

    </select>

    <select id="getLangByCode" resultType="map">
        SELECT
            P_CODE_CD,
            CODE_CD,
            CODE_NM,
            LANG_CD,
            REG_ID,
            REG_DT
        FROM TB_CM_CODE_LANG
        WHERE   P_CODE_CD = #{P_CODE_CD}
        AND     CODE_CD = #{CODE_CD}
    </select>

    <update id="saveLangCode">
        INSERT INTO TB_CM_CODE_LANG (LANG_CD, P_CODE_CD, CODE_CD, CODE_NM, REG_ID, REG_DT)
            VALUES (#{LANG_CD}, #{P_CODE_CD}, #{CODE_CD}, #{CODE_NM}, #{u_userId}, sysdate())
        ON DUPLICATE KEY
        UPDATE
           CODE_NM = #{CODE_NM},
            UPD_ID = #{u_userId},
            UPD_DT = sysdate()
    </update>

</mapper>