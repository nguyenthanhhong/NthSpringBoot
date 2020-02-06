package com.nth.standard.common.utility;

import java.util.HashMap;

/**
 * @class SqlBuilderForMySql
 * @author Hong Nguyen
 * @version 1.0
 */
public class SqlBuilderForMySql extends SqlBuilder {
    public String executeStoreProcedure(HashMap params) {
        String from = params.get("FROM").toString();
        String[] values = params.get("VALUE").toString().split(",");

        String sql = "{CALL " + from + "(";
        for(String value : values) {
            sql += "#{" + value + "},";
        }
        sql = sql.substring(0,sql.length() - 1);
        sql += ")}";
        return sql;
    }
    public String executeFunction(HashMap params) {
        String from = params.get("FROM").toString();
        String[] values = params.get("VALUE").toString().split(",");

        String sql = "Select " + from + "(";
        for(String value : values) {
            sql += "#{" + value + "},";
        }
        sql = sql.substring(0,sql.length() - 1);
        sql += ")";
        return sql;
    }
}
