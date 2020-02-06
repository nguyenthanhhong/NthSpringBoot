package com.nth.standard.common.utility;

import com.nth.standard.service.BaseService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @class CommonCodeUtil
 * @author Hong Nguyen
 * @version 1.0
 */
public class CommonCodeUtil {
    private static Map<String, Object> commonGroupCode;

    public static void init() {
        BaseService service = new BaseService();
        service.setSqlManager("mySqlSessionFactory");
        HashMap params = new HashMap();
        List<HashMap> groupCodeLst = service.queryForList(params,"CommonResourceService.getAllCommonCode");
        String langCd = "";
        String groupCd = "";
        List<HashMap> codeLst = new ArrayList<>();
        for(HashMap groupRow : groupCodeLst) {
            if(!"".equals(langCd) && (!langCd.equals(groupRow.get("LANG_CD")) || !groupCd.equals(groupRow.get("P_CODE_CD")))){
                commonGroupCode.put(langCd + "." + groupCd, ((ArrayList<HashMap>) codeLst).clone());
                codeLst.clear();
            }
            langCd = groupRow.get("LANG_CD").toString();
            groupCd = groupRow.get("P_CODE_CD").toString();
            codeLst.add(groupRow);
        }
        commonGroupCode.put(langCd + "." + groupCd, codeLst);
    }

    public static List<HashMap> getCodeList(String groupCd, String langCd) {
        if(commonGroupCode == null) {
            commonGroupCode = new HashMap<String, Object>();
            init();
        }
        List<HashMap> list = (List<HashMap>)commonGroupCode.get(langCd + "." + groupCd);
        return list;
    }
}
