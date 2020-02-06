package com.nth.standard.common.utility;

import com.nth.standard.common.model.Parameters;
import com.nth.standard.service.BaseService;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

/**
 * @class ReportUtil
 * @author Hong Nguyen
 * @version 1.0
 */
public class ReportUtil {
    public static HashMap getReportData(Parameters params, String SqlSessionBean) {
        BaseService service = new BaseService();
        service.setSqlManager(SqlSessionBean);
        HashMap rpVar = (HashMap)params.getData();
        List<HashMap> data = service.queryForList(rpVar.get("data"), rpVar.get("function").toString());
        HashMap result = new HashMap();
        result.put(Constants.REPORT_PARAM_NAME, rpVar.get(Constants.REPORT_PARAM_NAME));
        result.put(Constants.REPORT_PARAM_DATA, data);
        result.put(Constants.REPORT_PARAM_PARAMETERS, rpVar.get("data"));
        if(!data.isEmpty()) {
            result.put(Constants.REPORT_PARAM_COLUMN, makeColumnHeader(data.get(0)));
        }
        return result;
    }

    private static HashMap makeColumnHeader(HashMap data) {
        HashMap colName = new HashMap();
        Iterator<String> keys = data.keySet().iterator();
        while(keys.hasNext()) {
            String key = keys.next();
            colName.put(key, MessageUtil.getMessage(key));
        }
        return colName;
    }
    private HashMap makeExcelData(Parameters params) {
        return null;
    }
}
