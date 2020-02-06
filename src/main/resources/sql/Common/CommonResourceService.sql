<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="CommonResourceService">

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

	<select id="getAllCommonCode" resultType="map">
    	SELECT
    	    B.LANG_CD,
        	A.P_CODE_CD,
            A.P_CODE_NM,
            A.CODE_CD,
            A.CODE_NM,
            A.ORD,
            A.REF1,
            A.REF2,
            A.REF3,
            A.REF4,
            A.REF5
        FROM TB_CM_CODE A
        INNER JOIN TB_CM_CODE_LANG B
            ON B.P_CODE_CD = A.P_CODE_CD
            AND B.CODE_CD = A.CODE_CD
        WHERE A.USE_YN = '1'
        ORDER BY B.LANG_CD, A.P_CODE_CD, A.ORD
    </select>

	<select id="getLocalSetting" resultType="map">
    	SELECT
        	LANG_CD,
        	FN_CODE_NAME('LANG', LANG_CD)               AS LANG_NM,
            CURR_CD,
        	B.CODE_NM                                   AS CURR_NM,
        	B.REF1                                      AS CURR_RADIX,
            CURR_PLACE,
            FN_CODE_NAME('CURR_PLACE', CURR_PLACE)      AS CURR_PLACE_NM,
            FN_CODE_NAME('NUM_FORMAT', CURR_FORMAT)     AS CURR_FORMAT,
            D.CODE_NM                                   AS NUM_FORMAT,
            D.REF1                                      AS NUM_GROUP_SEPARATOR,
            D.REF2                                      AS NUM_RADIX_POINT,
            C.CODE_NM                                   AS DATE_FORMAT, /* year month day */
            C.REF1                                      AS DAY_FORMAT, /* day and month */
            C.REF2                                      AS MONTH_FORMAT, /* month and year */
            FN_CODE_NAME('TIME_FORMAT', TIME_FORMAT)    AS TIME_FORMAT,
            ROUND_TYPE,
            FN_CODE_NAME('ROUND_TYPE', ROUND_TYPE)      AS ROUND_TYPE_NM
        FROM TB_CM_LOCAL A
        LEFT JOIN TB_CM_CODE B
        ON B.P_CODE_CD = 'CURRENCY'
        AND B.CODE_CD = A.CURR_CD
        LEFT JOIN TB_CM_CODE C
        ON C.P_CODE_CD = 'DATE_FORMAT'
        AND C.CODE_CD = A.DATE_FORMAT
        LEFT JOIN TB_CM_CODE D
        ON D.P_CODE_CD = 'NUM_FORMAT'
        AND D.CODE_CD = A.NUM_FORMAT
        WHERE A.USE_YN = '1'
        LIMIT 1
    </select>

</mapper>