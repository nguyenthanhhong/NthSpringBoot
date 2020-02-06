<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="MessageService">
	<select id="getMsgList" resultType="map">
    	SELECT
    	        MSG_CD,
    	        MAX(USE_YN) AS USE_YN,
    	        MAX(REG_ID) AS REG_ID
        FROM    TB_CM_MESSAGE
        WHERE   1 = 1
        <if test='S_MSG_CD != null and S_MSG_CD == "0"'>
            AND MSG_CD = #{S_MSG_CD}
        </if>
        <if test='S_MSG_NM != null and S_MSG_NM == "0"'>
            AND MSG_NM = #{S_MSG_NM}
        </if>
        <if test='S_USE_YN != null and S_USE_YN == "0"'>
            AND USE_YN = #{S_USE_YN}
        </if>

        GROUP BY MSG_CD
    </select>

    <select id="getLangByMsg" resultType="map">
        SELECT
            MSG_CD,
            MSG_NM,
            LANG_CD,
            USE_YN,
            REG_ID,
            REG_DT
        FROM TB_CM_MESSAGE
        WHERE   MSG_CD = #{MSG_CD}
    </select>

    <update id="saveMsg">
        INSERT INTO TB_CM_MESSAGE (MSG_CD, MSG_NM, LANG_CD, USE_YN, REG_ID, REG_DT)
            VALUES (#{MSG_CD}, #{MSG_NM}, #{LANG_CD}, #{USE_YN}, #{u_userId}, sysdate())
        ON DUPLICATE KEY
        UPDATE
            MSG_NM = #{MSG_NM},
            USE_YN = #{USE_YN},
            UPD_ID = #{u_userId},
            REG_DT = sysdate()
    </update>

</mapper>