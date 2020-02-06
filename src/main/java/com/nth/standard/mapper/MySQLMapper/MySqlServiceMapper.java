package com.nth.standard.mapper.MySQLMapper;

import com.nth.standard.common.utility.SqlBuilderForMySql;
import com.nth.standard.config.databaseConfig.MysqlConnMapper;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.StatementType;

import java.util.HashMap;
import java.util.List;

/**
 * @class MySqlServiceMapper
 * @author Hong Nguyen
 * @version 1.0
 */
@MysqlConnMapper
public interface MySqlServiceMapper {
    int getCountMysql();
    int checkPage(HashMap params);
    HashMap getPage(HashMap params);

    @SelectProvider(type= SqlBuilderForMySql.class,method="selectDataTable")
    List<HashMap> selectDataTable(HashMap params);

    @InsertProvider(type= SqlBuilderForMySql.class,method="insertDataTable")
    HashMap insertDataTable(HashMap params);

    @UpdateProvider(type= SqlBuilderForMySql.class,method="updateDataTable")
    HashMap updateDataTable(HashMap params);

    @DeleteProvider(type= SqlBuilderForMySql.class,method="deleteDataTable")
    HashMap deleteDataTable(HashMap params);

    @SelectProvider(type= SqlBuilderForMySql.class,method="executeStoreProcedure")
    @Options(statementType = StatementType.CALLABLE)
    HashMap executeStoreProcedure(HashMap params);

    @SelectProvider(type= SqlBuilderForMySql.class,method="executeFunction")
    HashMap executeFunction(HashMap params);

}
