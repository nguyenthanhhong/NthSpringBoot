<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="LabelService">
	<select id="getLabelList" resultType="map">
    	SELECT
    	        LABEL_CD,
    	        MAX(USE_YN) AS USE_YN,
    	        MAX(REG_ID) AS REG_ID
        FROM    TB_CM_LABEL
        WHERE   1 = 1
        <if test='S_LABEL_NM != null and S_LABEL_NM == "0"'>
            AND LABEL_CD = #{S_LABEL_NM}
        </if>
        <if test='S_CODE_NM != null and S_CODE_NM == "0"'>
            AND LABEL_NM = #{S_CODE_NM}
        </if>
        <if test='S_USE_YN != null and S_USE_YN == "0"'>
            AND USE_YN = #{S_USE_YN}
        </if>

        GROUP BY LABEL_CD
    </select>

    <select id="getLangByLabel" resultType="map">
        SELECT
            LABEL_CD,
            LABEL_NM,
            LANG_CD,
            USE_YN,
            REG_ID,
            REG_DT
        FROM TB_CM_LABEL
        WHERE   LABEL_CD = #{LABEL_CD}
    </select>

    <update id="saveLabel">
        INSERT INTO TB_CM_LABEL (LABEL_CD, LABEL_NM, LANG_CD, USE_YN, REG_ID, REG_DT)
            VALUES (#{LABEL_CD}, #{LABEL_NM}, #{LANG_CD}, #{USE_YN}, #{u_userId}, sysdate())
        ON DUPLICATE KEY
        UPDATE
            LABEL_NM = #{LABEL_NM},
            USE_YN = #{USE_YN},
            UPD_ID = #{u_userId},
            REG_DT = sysdate()
    </update>

</mapper>