<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.nth.standard.mapper.MySQLMapper.MessageResourceMapper">

	<select id="getAllLabel" resultType="map">
    	SELECT
        	CONCAT(LANG_CD,'.', LABEL_CD) LABEL_CD,
            LABEL_NM
        FROM TB_CM_LABEL
        WHERE USE_YN = '1'
    </select>

	<select id="getAllMessage" resultType="map">
    	SELECT
        	CONCAT(LANG_CD,'.', MSG_CD) MSG_CD,
            MSG_NM
        FROM TB_CM_MESSAGE
        WHERE USE_YN = '1'
    </select>

	<select id="getLangList" resultType="string">
    	SELECT CODE_CD
        FROM tb_cm_code
        WHERE P_CODE_CD='LANG'
        AND USE_YN = '1'
    </select>

</mapper>