package com.nth.standard.service;

import com.nth.standard.mapper.MySQLMapper.MenuServiceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * @class MenuService
 * @author Hong Nguyen
 * @version 1.0
 */
@Service
public class MenuService extends BaseService{
    @Autowired
    private MenuServiceMapper cmMenuMapper;

    public List<HashMap> getMenuListAppliedForAuthForSystemClTop(HashMap params){
        return this.cmMenuMapper.getMenuListAppliedForAuthForSystem(params);
    }

    public List<String> getPermittedRolesByUrl(HashMap params) {
        return this.cmMenuMapper.getPermittedRolesByUrl(params);
    }

    public List<HashMap> getUserMenuList(HashMap params) {
        return queryForList(params, "com.nth.standard.mapper.MySQLMapper.MenuServiceMapper.getUserMenuList");
    }

    public HashMap getLocalSetting() {
        HashMap params = new HashMap();
        return (HashMap)queryForObject(params, "CommonResourceService.getLocalSetting");
    }
}
