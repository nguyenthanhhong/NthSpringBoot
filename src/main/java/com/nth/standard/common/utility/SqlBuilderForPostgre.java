package com.nth.standard.common.utility;

import java.util.HashMap;

/**
 * @class SqlBuilderForPostgre
 * @author Hong Nguyen
 * @version 1.0
 */
public class SqlBuilderForPostgre extends SqlBuilder {
    public String executeStoreProcedure(HashMap params) {
        String froms = params.get("FROM").toString();
        String[] values = params.get("VALUE").toString().split(",");

        String sql = "{CALL " + froms + "(";
        for(String value : values) {
            sql += "#{" + value + "},";
        }
        sql = sql.substring(0,sql.length() - 1);
        sql += ")}";
        return sql;
    }
}
