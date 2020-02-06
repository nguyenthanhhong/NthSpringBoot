<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.nth.standard.mapper.PostgreMapper.PostgreServiceMapper">

	<select id="getPage" resultType="string">
    	SELECT
    	        LOCAL_URL
        FROM    TB_CM_PROGRAM A
             INNER JOIN TB_CM_AUTH_PROGRAM B
                 ON B.PRG_CD = A.PRG_CD
             INNER JOIN TB_CM_USER_AUTH C
                 ON C.AUTH_CD = B.AUTH_CD
        WHERE   A.PRG_URL = #{PROG_URL}
        AND     C.USER_ID = #{userId}
    </select>
    <select id="getDataTable" resultType="map">
        SELECT * FROM TB_CM_USER WHERE USER_ID=#{userId}
    </select>
    <select id="runProcedure" resultType="map">
        SELECT * FROM TB_CM_USER WHERE USER_ID=#{userId}
    </select>

</mapper>