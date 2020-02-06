package com.nth.standard.service;

import com.nth.standard.mapper.MySQLMapper.MySqlServiceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * @class CommonCodeService
 * @author Hong Nguyen
 * @version 1.0
 */
@Service
public class CommonCodeService extends BaseService {
    @Autowired
    MySqlServiceMapper mysqlServiceMapper;

    public List<HashMap> getSelectList(HashMap params) {
        return queryForList(params, "CommonCodeService." + params.get("sqlId"));
    }
}
