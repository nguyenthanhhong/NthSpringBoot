package com.nth.standard.mapper.MySQLMapper;

import com.nth.standard.config.databaseConfig.MysqlConnMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
@MysqlConnMapper
public interface MenuServiceMapper {
    List<HashMap> getMenuListAppliedForAuthForSystem(HashMap params);

    List<String> getPermittedRolesByUrl(HashMap params);
}
