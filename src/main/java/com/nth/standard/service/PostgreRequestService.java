package com.nth.standard.service;

import com.nth.standard.mapper.PostgreMapper.PostgreServiceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * @class PostgreRequestService
 * @author Hong Nguyen
 * @version 1.0
 */
@Service
public class PostgreRequestService {
    @Autowired
    PostgreServiceMapper postgreServiceMapper;

    public HashMap getPage(HashMap params) {
        return postgreServiceMapper.getPage(params);
    }

    public List<HashMap> getDataTable(HashMap params) {
        return postgreServiceMapper.getDataTable(params);
    }

    public HashMap runProcedure(HashMap params) {
        return postgreServiceMapper.runProcedure(params);
    }

}
