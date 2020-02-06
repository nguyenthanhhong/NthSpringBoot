package com.nth.standard.mapper.PostgreMapper;

import com.nth.standard.config.databaseConfig.PostgreConnMapper;

import java.util.HashMap;
import java.util.List;

/**
 * @class PostgreServiceMapper
 * @author Hong Nguyen
 * @version 1.0
 */
@PostgreConnMapper
public interface PostgreServiceMapper {
    int getCountOracle();

    HashMap getPage(HashMap params);
    List<HashMap> getDataTable(HashMap params);
    HashMap runProcedure(HashMap params);
}
