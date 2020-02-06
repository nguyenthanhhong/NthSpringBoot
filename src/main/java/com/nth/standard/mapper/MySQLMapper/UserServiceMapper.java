package com.nth.standard.mapper.MySQLMapper;


import com.nth.standard.config.databaseConfig.MysqlConnMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
@MysqlConnMapper
public interface UserServiceMapper {
    HashMap getUser(HashMap params);
    HashMap findUserAccount(String userId);
    List<String> getUserRoles(String userId);
    List<String> getAllRoles();
}
