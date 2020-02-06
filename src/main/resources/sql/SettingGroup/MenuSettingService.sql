<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="MenuSettingService">
	<update id="updateMenu">
        UPDATE TB_CM_MENU /* [MenuSettingService.sql][updateMenu] */
        SET
            P_MENU_CD   = #{P_PRG_CD},
            LVL         = #{LVL},
            UPD_ID      = #{u_userId},
            UPD_DT      = sysdate()
        WHERE MENU_CD   = #{PRG_CD}
    </update>

    <select id="getProgramList" resultType="map">
        SELECT /* [MenuSettingService.sql][getProgramList] */
            A.SRT                            AS SRT,
            A.P_PRG_CD,
            A.PRG_CD,
            COALESCE(B.PRG_NM, A.PRG_NM)   AS PRG_NM,
            A.LVL,
            A.PRG_LVL,
            A.PROG_NO,
            A.PRG_URL,
            A.LOCAL_URL,
            A.DB_CD,
            A.USE_YN,
            A.MENU_YN,
            COALESCE(B.BTN1_NM, A.BTN1_NM)   AS BTN1_NM,
            COALESCE(B.BTN2_NM, A.BTN2_NM)   AS BTN2_NM,
            COALESCE(B.BTN3_NM, A.BTN3_NM)   AS BTN3_NM,
            COALESCE(B.BTN4_NM, A.BTN4_NM)   AS BTN4_NM,
            COALESCE(B.BTN5_NM, A.BTN5_NM)   AS BTN5_NM,
            COALESCE(B.BTN6_NM, A.BTN6_NM)   AS BTN6_NM,
            COALESCE(B.BTN7_NM, A.BTN7_NM)   AS BTN7_NM,
            COALESCE(B.BTN8_NM, A.BTN8_NM)   AS BTN8_NM,
            COALESCE(B.BTN9_NM, A.BTN9_NM)   AS BTN9_NM,
            COALESCE(B.BTN10_NM, A.BTN10_NM) AS BTN10_NM,
            A.NOTE,
            A.SCH_TERM,
            A.SCH_FR_CD,
            A.SCH_FR_DT,
            A.SCH_TO_CD,
            A.SCH_TO_DT,
            A.REG_ID,
            A.REG_DT,
            A.UPD_ID,
            A.UPD_DT
        FROM   VW_PRG_MENU A
        LEFT   JOIN TB_CM_PROGRAM_LANG B
        ON     B.PRG_CD = A.PRG_CD
        AND    B.LANG_CD = #{u_langCd}
        WHERE 1 = 1
    </select>

    <update id="saveProgram" statementType="CALLABLE">
        {   call SP_MAKE_PROGRAM_MENU (
                #{P_PRG_CD,		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{LVL,			mode=IN, jdbcType=DECIMAL, javaType=Integer},
                #{PRG_CD, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{PRG_NM, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{DB_CD, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{USE_YN, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{MENU_YN, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{PRG_URL, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{LOCAL_URL,	mode=IN, jdbcType=VARCHAR, javaType=string},
                #{BTN1_NM, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{BTN2_NM, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{BTN3_NM, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{BTN4_NM, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{BTN5_NM, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{BTN6_NM, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{BTN7_NM, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{BTN8_NM, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{BTN9_NM, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{BTN10_NM, 	mode=IN, jdbcType=VARCHAR, javaType=string},
                #{SCH_TERM, 	mode=IN, jdbcType=DECIMAL, javaType=object},
                #{SCH_FR_CD, 	mode=IN, jdbcType=VARCHAR, javaType=string},
                #{SCH_FR_DT, 	mode=IN, jdbcType=VARCHAR, javaType=string},
                #{SCH_TO_CD, 	mode=IN, jdbcType=VARCHAR, javaType=string},
                #{SCH_TO_DT, 	mode=IN, jdbcType=VARCHAR, javaType=string},
                #{NOTE, 		mode=IN, jdbcType=VARCHAR, javaType=string},
                #{u_userId, 	mode=IN, jdbcType=VARCHAR, javaType=string},
                #{O_RET, 		mode=OUT, jdbcType=DECIMAL, javaType=object},
                #{O_MSG_CD, 	mode=OUT, jdbcType=VARCHAR, javaType=string}
            )
        }

    </update>

</mapper>