<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.nth.standard.mapper.MySQLMapper.UserServiceMapper">

	<select id="getUser" resultType="map">
    	SELECT * FROM TB_CM_USER WHERE USER_ID=#{userId}
    </select>

	<select id="findUserAccount" resultType="map">
    	SELECT * FROM TB_CM_USER WHERE USER_ID=#{userId}
    </select>

	<select id="getUserRoles" resultType="string">
    	SELECT AUTH_CD
    	FROM tb_cm_user_auth
    	WHERE USER_ID = #{userId}
    </select>

	<select id="getAllRoles" resultType="string">
    	SELECT AUTH_CD
    	FROM tb_cm_auth
    	WHERE USE_YN = '1'
    </select>

	<select id="existsByUserId" resultType="map">
    	SELECT 1 FROM TB_CM_USER WHERE USER_ID=#{userId}
    </select>

    <insert id="save">
        INSERT INTO TB_CM_USER (USER_ID, USER_PW, USER_MN)
        VALUES (
                #{userId},
                #{pw},
                #{userNm}
         )
    </insert>

    <delete id="deleteByUserId">
        DELETE FROM TB_CM_USER WHERE USER_ID = #{userId}
    </delete>

</mapper>