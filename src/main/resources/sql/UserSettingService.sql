<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="UserSettingService">
	<select id="getUserList" resultType="map">
    	SELECT
    	        USER_ID,
    	        USER_NM,
    	        EMAIL,
    	        PHONE,
    	        ADDRESS
        FROM    TB_CM_USER
        WHERE   1 = 1
        <if test='USER_ID != null and USER_ID == "0"'>
            AND USER_ID = #{USER_ID}
        </if>
        <if test='USER_NM != null and USER_NM == "0"'>
            AND USER_NM = #{USER_NM}
        </if>
        <if test='S_USE_YN != null and S_USE_YN == "0"'>
            AND USE_YN = #{S_USE_YN}
        </if>
    </select>

    <update id="saveUserSetting">
        UPDATE TB_CM_USER
        SET
            USER_NM = #{USER_NM},
            EMAIL = #{EMAIL},
            PHONE = #{PHONE},
            ADDRESS = #{ADDRESS},
            USE_YN = #{USE_YN},
            UPD_ID = #{u_userId},
            REG_DT = sysdate()
        WHERE USER_ID = #{USER_ID}
    </update>

    <select id="getUserAuthList" resultType="map">
    	SELECT
    	        A.USER_ID,
    	        A.AUTH_CD,
    	        A.USE_YN,
    	        B.USER_NM,
    	        C.AUTH_NM
        FROM    TB_CM_USER_AUTH A
        INNER JOIN TB_CM_USER B
        ON B.USER_ID = A.USER_ID
        INNER JOIN TB_CM_AUTH C
        ON C.AUTH_CD = A.AUTH_CD
        WHERE   1 = 1
        <if test='USER_ID != null and USER_ID == "0"'>
            AND A.USER_ID = #{USER_ID}
        </if>
        <if test='USER_NM != null and USER_NM == "0"'>
            AND USER_NM = #{USER_NM}
        </if>
        <if test='S_USE_YN != null and S_USE_YN == "0"'>
            AND A.USE_YN = #{S_USE_YN}
        </if>
    </select>

</mapper>