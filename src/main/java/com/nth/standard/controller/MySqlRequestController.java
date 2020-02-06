package com.nth.standard.controller;

import com.nth.standard.common.model.Parameters;
import com.nth.standard.common.utility.StringUtil;
import com.nth.standard.service.MySqlRequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Iterator;

/**
 * @class MySqlRequestController
 * @author Hong Nguyen
 * @version 1.0
 */
@Controller
@RequestMapping("/mysql")
public class MySqlRequestController {
    @Autowired
    MySqlRequestService mySqlRequestService;
    @RequestMapping("/")
    public ModelAndView page(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("error/404");

        return modelAndView;
    }

    @RequestMapping(value = "/{page}")
    public ModelAndView page1(HttpServletRequest request, HttpServletResponse response, @PathVariable("page") String page) {
        HashMap params = new HashMap();
        HttpSession session = request.getSession();
        params.put("URL", page);
        params.put("USER_ID", StringUtil.toString(session.getAttribute("u_userId")));
        params.put("LANG_CD", StringUtil.toString(session.getAttribute("u_langCd")));

        return getPageSetting(params, session);
    }
    @RequestMapping(value = "{url}/{page}")
    public ModelAndView page2(HttpServletRequest request, HttpServletResponse response, @PathVariable("url") String url, @PathVariable("page") String page) {
        HashMap params = new HashMap();
        HttpSession session = request.getSession();
        params.put("URL", String.format( "%s/%s", url,page));
        params.put("USER_ID", StringUtil.toString(session.getAttribute("u_userId")));
        params.put("LANG_CD", StringUtil.toString(session.getAttribute("u_langCd")));
        return getPageSetting(params, session);
    }
    @RequestMapping(value = "{url1}/{url2}/{page}")
    public ModelAndView page3(HttpServletRequest request, HttpServletResponse response, @PathVariable("url1") String url1, @PathVariable("url2") String url2, @PathVariable("page") String page) {
        HashMap params = new HashMap();
        HttpSession session = request.getSession();
        params.put("URL", String.format( "%s/%s/%s", url1,url2,page));
        params.put("USER_ID", StringUtil.toString(session.getAttribute("u_userId")));
        params.put("LANG_CD", StringUtil.toString(session.getAttribute("u_langCd")));
        return getPageSetting(params, session);
    }
    @RequestMapping(value = "{url1}/{url2}/{url3}/{page}")
    public ModelAndView page4(HttpServletRequest request, HttpServletResponse response, @PathVariable("url1") String url1, @PathVariable("url2") String url2, @PathVariable("url3") String url3, @PathVariable("page") String page) {
        HashMap params = new HashMap();
        HttpSession session = request.getSession();
        params.put("URL", String.format( "%s/%s/%s/%s", url1,url2,url3,page));
        params.put("USER_ID", StringUtil.toString(session.getAttribute("u_userId")));
        params.put("LANG_CD", StringUtil.toString(session.getAttribute("u_langCd")));
        return getPageSetting(params, session);
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public @ResponseBody
    HashMap search(@RequestBody HashMap params){
        HashMap dataSource = new HashMap();
        dataSource.put("data",mySqlRequestService.getDataTable(params));
        return dataSource;
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    public @ResponseBody
    HashMap insert(@RequestBody HashMap params){
        HashMap dataSource = new HashMap();
        dataSource.put("data",mySqlRequestService.insertDataTable(params));
        return dataSource;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public @ResponseBody
    HashMap update(@RequestBody HashMap params){
        HashMap dataSource = new HashMap();
        dataSource.put("data",mySqlRequestService.updateDataTable(params));
        return dataSource;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public @ResponseBody
    HashMap delete(@RequestBody HashMap params){
        HashMap dataSource = new HashMap();
        dataSource.put("data",mySqlRequestService.deleteDataTable(params));
        return dataSource;
    }

    @RequestMapping(value = "/executeProcedure", method = RequestMethod.POST)
    public @ResponseBody
    HashMap executeProcedure(@RequestBody HashMap params){
        HashMap dataSource = new HashMap();
        dataSource.put("data",mySqlRequestService.executeStoreProcedure(params));
        return dataSource;
    }

    @RequestMapping(value = "/sqlList")
    public @ResponseBody
    Parameters callSqlSession4List(Parameters params) {
        Parameters dataSource =new Parameters();
        dataSource.setVariables(mySqlRequestService.sqlSelect((HashMap)params.getData()));
        return dataSource;
    }

    @RequestMapping(value = "/sqlObject", method = RequestMethod.POST)
    public @ResponseBody
    Parameters callSqlSession4Object(Parameters params){
        Parameters dataSource = new Parameters();
        dataSource.setVariables(mySqlRequestService.sqlSelectObject((HashMap)params.getData()));
        return dataSource;
    }


    @RequestMapping(value = "/sqlInsert", method = RequestMethod.POST)
    public @ResponseBody
    Parameters callSqlSession4Insert(Parameters params){
        Parameters dataSource = new Parameters();
        dataSource.setVariables(mySqlRequestService.sqlInsert((HashMap)params.getData()));
        return dataSource;
    }


    @RequestMapping(value = "/sqlUpdate", method = RequestMethod.POST)
    public @ResponseBody
    Parameters callSqlSession4Update(Parameters params){
        Parameters dataSource = new Parameters();
        dataSource.setVariables(mySqlRequestService.sqlUpdate((HashMap)params.getData()));
        return dataSource;
    }

    @RequestMapping(value = "/sqlDelete", method = RequestMethod.POST)
    public @ResponseBody
    Parameters callSqlSession4Delete(Parameters params){
        Parameters dataSource = new Parameters();
        dataSource.setVariables(mySqlRequestService.sqlDelete((HashMap)params.getData()));
        return dataSource;
    }

    @RequestMapping(value = "/sqlCall", method = RequestMethod.POST)
    public @ResponseBody
    Parameters callSqlSession4SP(Parameters params){
        Parameters dataSource = new Parameters();
        HashMap result = mySqlRequestService.sqlCallSP((HashMap)params.getData());
        dataSource.setErrorCode(result.get("O_RET").toString());
        dataSource.setErrorMessage(result.get("O_MSG_CD").toString());
        return dataSource;
    }

    ModelAndView getPageSetting(HashMap params, HttpSession session) {
        HashMap curr_page = (HashMap)session.getAttribute(params.get("URL").toString());
        if(curr_page != null) {
            session.setAttribute("CURR_PAGE",curr_page);
            return new ModelAndView(StringUtil.toString(curr_page.get("LOCAL_URL")));
        }

        HashMap pageInfor = mySqlRequestService.getPage(params);
        if(pageInfor == null || pageInfor.get("LOCAL_URL") == null) {
            return new ModelAndView("error/404");

        } else if("0".equals(pageInfor.get("IS_AUTH").toString())) {
            return new ModelAndView("error/403");
        }

        HashMap newPage = new HashMap();
        Iterator<String> keys = pageInfor.keySet().iterator();
        while(keys.hasNext()) {
            String key = keys.next();
            newPage.put(key,pageInfor.get(key));
        }
        session.setAttribute("CURR_PAGE", newPage);
        session.setAttribute(params.get("URL").toString(), newPage);

        return new ModelAndView(StringUtil.toString(pageInfor.get("LOCAL_URL")));
    }
}
