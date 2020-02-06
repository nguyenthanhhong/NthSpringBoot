package com.nth.standard.common.utility;

import org.apache.ibatis.jdbc.SQL;

import java.util.HashMap;

/**
 * @class SqlBuilder
 * @author Hong Nguyen
 * @version 1.0
 */
public class SqlBuilder {
    public String selectDataTable(HashMap params) {
        String[] selects = params.get("SELECT").toString().split(",");
        String[] froms = params.get("FROM").toString().split(",");
        String[] inners = params.get("INNER_JOIN").toString().split(",");
        String[] lefts = params.get("LEFT_JOIN").toString().split(",");
        String[] wheres = params.get("WHERE").toString().split(",");
        String[] ors = params.get("OR").toString().split(",");
        String[] groups = params.get("GROUP_BY").toString().split(",");
        String[] havings = params.get("HAVING").toString().split(",");
        String[] orders = params.get("ORDER_BY").toString().split(",");

        String sql = new SQL() {{
            for (String select : selects) {
                SELECT(select);
            }
            for (String from : froms) {
                FROM(from);
            }
            for (String inner : inners) {
                if (!inner.isEmpty()) {
                    INNER_JOIN(inner);
                }
            }
            for (String left : lefts) {
                if (!left.isEmpty()) {
                    LEFT_OUTER_JOIN(left);
                }
            }
            for (String where : wheres) {
                String value = params.get(where).toString();
                if (!where.isEmpty() && !value.isEmpty()) {
                    WHERE(where + "=" + value);
                }
            }
            if (ors.length > 0) {
                for (String or : ors) {
                    String value = params.get(or).toString();
                    if (!or.isEmpty() && !value.isEmpty()) {
                        WHERE(or + "=" + value);
                    }
                }
            }

            for (String group : groups) {
                if (!group.isEmpty()) {
                    GROUP_BY(group);
                }
            }
            for (String having : havings) {
                if (!having.isEmpty()) {
                    HAVING(having);
                }
            }
            for (String order : orders) {
                if (!order.isEmpty()) {
                    ORDER_BY(order);
                }
            }
        }}.toString();
        return sql;
    }

    public String insertDataTable(HashMap params) {
        String froms = params.get("FROM").toString();
        String[] values = params.get("VALUE").toString().split(",");
        String sql = new SQL() {{
            INSERT_INTO(froms);
            for (String col : values) {
                String value = params.get(col).toString();
                if (!col.isEmpty() && !value.isEmpty()) {
                    VALUES(col, value);
                }
            }
        }}.toString();
        return sql;
    }

    public String updateDataTable(HashMap params) {
        String froms = params.get("FROM").toString();
        String[] values = params.get("VALUE").toString().split(",");
        String[] wheres = params.get("WHERE").toString().split(",");
        String sql = new SQL() {{
            UPDATE(froms);
            for (String col : values) {
                String value = params.get(col).toString();
                if (!col.isEmpty() && !value.isEmpty()) {
                    SET(col + " = "+ value);
                }
            }
            for (String where : wheres) {
                String value = params.get(where).toString();
                if (!where.isEmpty() && !value.isEmpty()) {
                    WHERE(where + " = "+ value);
                }
            }
        }}.toString();
        return sql;
    }

    public String deleteDataTable(HashMap params) {
        String froms = params.get("FROM").toString();
        String[] wheres = params.get("WHERE").toString().split(",");
        String sql = new SQL() {{
            DELETE_FROM(froms);
            for (String where : wheres) {
                String value = params.get(where).toString();
                if (!where.isEmpty() && !value.isEmpty()) {
                    WHERE(where + " = " + value);
                }
            }
        }}.toString();
        return sql;
    }
}
