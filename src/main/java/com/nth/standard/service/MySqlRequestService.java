package com.nth.standard.service;

import com.nth.standard.common.model.UserHandleException;
import com.nth.standard.common.utility.StringUtil;
import com.nth.standard.mapper.MySQLMapper.MySqlServiceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

import static com.nth.standard.common.utility.Constants.*;

/**
 * @class MySqlRequestService
 * @author Hong Nguyen
 * @version 1.0
 */
@Service
public class MySqlRequestService extends BaseService {
    @Autowired
    MySqlServiceMapper mysqlServiceMapper;

    public int checkPage(HashMap params) {
        return mysqlServiceMapper.checkPage(params);
    }

    public HashMap getPage(HashMap params) {
        return mysqlServiceMapper.getPage(params);
    }

    public List<HashMap> getDataTable(HashMap params) {
        HashMap inParams = (HashMap) params.get("data");
        if (!validationQuery(params, FUNC_SELECT)) {
            throw new UserHandleException("MSG_ERR_WRONG_PARAM");
        }
        return mysqlServiceMapper.selectDataTable(inParams);
    }

    public HashMap insertDataTable(HashMap params) {
        HashMap inParams = (HashMap) params.get("data");
        if (!validationQuery(params, FUNC_INSERT)) {
            throw new UserHandleException("MSG_ERR_WRONG_PARAM");
        }
        return mysqlServiceMapper.insertDataTable(inParams);
    }

    public HashMap updateDataTable(HashMap params) {
        HashMap inParams = (HashMap) params.get("data");
        if (!validationQuery(params, FUNC_UPDATE)) {
            throw new UserHandleException("MSG_ERR_WRONG_PARAM");
        }
        return mysqlServiceMapper.updateDataTable(inParams);
    }

    public HashMap deleteDataTable(HashMap params) {
        HashMap inParams = (HashMap) params.get("data");
        if (!validationQuery(params, FUNC_DELETE)) {
            throw new UserHandleException("MSG_ERR_WRONG_PARAM");
        }
        return mysqlServiceMapper.deleteDataTable(inParams);
    }

    public HashMap executeStoreProcedure(HashMap params) {
        HashMap inParams = (HashMap) params.get("data");
        if (!validationQuery(params, FUNC_PROC)) {
            throw new UserHandleException("MSG_ERR_WRONG_PARAM");
        }
        return mysqlServiceMapper.executeStoreProcedure(inParams);
    }

    public HashMap executeFunction(HashMap params) {
        HashMap inParams = (HashMap) params.get("data");
        if (!validationQuery(params, FUNC_PROC)) {
            throw new UserHandleException("MSG_ERR_WRONG_PARAM");
        }
        return mysqlServiceMapper.executeFunction(inParams);
    }

    public List<HashMap> sqlSelect(HashMap params) {
        if (!validationQuery(params, FUNC_SQL_SESSION)) {
            throw new UserHandleException("MSG_ERR_WRONG_PARAM");
        }
        return queryForList(params.get("data"), params.get("function").toString());
    }

    public HashMap sqlSelectObject(HashMap params) {
        if (!validationQuery(params, FUNC_SQL_SESSION)) {
            throw new UserHandleException("MSG_ERR_WRONG_PARAM");
        }
        return (HashMap) queryForObject(params.get("data"), params.get("function").toString());
    }

    public int sqlInsert(HashMap params) {
        if (!validationQuery(params, FUNC_SQL_SESSION)) {
            throw new UserHandleException("MSG_ERR_WRONG_PARAM");
        }
        return insert(params.get("data"), params.get("function").toString());
    }

    public int sqlUpdate(HashMap params) {
        if (!validationQuery(params, FUNC_SQL_SESSION)) {
            throw new UserHandleException("MSG_ERR_WRONG_PARAM");
        }
        return update(params.get("data"), params.get("function").toString());
    }

    public int sqlDelete(HashMap params) {
        if (!validationQuery(params, FUNC_SQL_SESSION)) {
            throw new UserHandleException("MSG_ERR_WRONG_PARAM");
        }
        return delete(params.get("data"), params.get("function").toString());
    }

    public HashMap sqlCallSP(HashMap params) {
        if (!validationQuery(params, FUNC_SQL_SESSION)) {
            throw new UserHandleException("MSG_ERR_WRONG_PARAM");
        }
        return (HashMap) callSp(params.get("data"), params.get("function").toString());
    }

    private boolean validationQuery(HashMap params, String function) {
        if(StringUtil.isEmpty(params)){
            return false;
        }
        switch (function) {
            case FUNC_SELECT:
                if (StringUtil.isEmpty(params.get("SELECT")) || StringUtil.isEmpty(params.get("FROM")) || StringUtil.isEmpty(params.get("WHERE"))) {
                    return false;
                }
                break;
            case FUNC_UPDATE:
                if (StringUtil.isEmpty(params.get("FROM")) || StringUtil.isEmpty(params.get("VALUE")) || StringUtil.isEmpty(params.get("WHERE"))) {
                    return false;
                }
                break;
            case FUNC_INSERT:
            case FUNC_DELETE:
            case FUNC_PROC:
                if (StringUtil.isEmpty(params.get("FROM")) || StringUtil.isEmpty(params.get("VALUE"))) {
                    return false;
                }
                break;
            case FUNC_SQL_SESSION:
                if (StringUtil.isEmpty(params.get("data")) || StringUtil.isEmpty(params.get("function"))) {
                    return false;
                }
                break;
            default:
                return false;
        }
        return true;
    }
}
