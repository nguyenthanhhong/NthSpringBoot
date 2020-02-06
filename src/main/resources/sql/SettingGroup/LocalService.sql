<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="LocalService">
	<select id="getLocalData" resultType="map">
    	SELECT
            ID,
            LANG_CD,
            CURR_CD,
            CURR_PLACE,
            CURR_FORMAT,
            DATE_FORMAT,
            TIME_FORMAT,
            NUM_FORMAT,
            ROUND_TYPE,
            USE_YN,
            UPD_ID,
            UPD_DT
        FROM TB_CM_LOCAL
    </select>

    <update id="saveLocalSetting">
        INSERT INTO TB_CM_LOCAL (
            ID,
            LANG_CD,
            CURR_CD,
            CURR_PLACE,
            CURR_FORMAT,
            DATE_FORMAT,
            TIME_FORMAT,
            NUM_FORMAT,
            ROUND_TYPE,
            USE_YN,
            UPD_ID,
            UPD_DT
        )
        VALUES (
            COALESCE(#{ID}, 1),
            #{LANG_CD},
            #{CURR_CD},
            #{CURR_PLACE},
            #{CURR_FORMAT},
            #{DATE_FORMAT},
            #{TIME_FORMAT},
            #{NUM_FORMAT},
            #{ROUND_TYPE},
            #{USE_YN},
            #{u_userId},
            sysdate()
        )
        ON DUPLICATE KEY
        UPDATE
            LANG_CD = #{LANG_CD},
            CURR_CD = #{CURR_CD},
            CURR_PLACE = #{CURR_PLACE},
            CURR_FORMAT = #{CURR_FORMAT},
            DATE_FORMAT = #{DATE_FORMAT},
            TIME_FORMAT = #{TIME_FORMAT},
            NUM_FORMAT = #{NUM_FORMAT},
            ROUND_TYPE = #{ROUND_TYPE},
            UPD_ID = #{u_userId},
            UPD_DT = sysdate()
    </update>

    <update id="applyLocalSetting">
        UPDATE TB_CM_LOCAL
        SET
            USE_YN = IF(#{ID} = ID, '1', '0'),
            UPD_ID = #{u_userId},
            UPD_DT = sysdate()
    </update>

</mapper>