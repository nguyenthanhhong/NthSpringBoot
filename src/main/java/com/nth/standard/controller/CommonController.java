package com.nth.standard.controller;

import com.nth.standard.common.model.Parameters;
import com.nth.standard.common.utility.Constants;
import com.nth.standard.common.utility.MessageUtil;
import com.nth.standard.common.utility.ReportUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

/**
 * @class CommonController
 * @author Hong Nguyen
 * @version 1.0
 */
@Controller
@RequestMapping("/main")
public class CommonController {

    @RequestMapping(value = "/reloadMsgSource", method = RequestMethod.GET)
    @ResponseBody
    public String reloadMsgSource(HttpServletRequest Request) {
        MessageUtil.reloadLabelResource(Constants.RELOAD_SOURCE_MSG);
        return "1";
    }

    @RequestMapping(value = "/reloadLblSource", method = RequestMethod.GET)
    @ResponseBody
    public String reloadLblSource(HttpServletRequest Request) {
        MessageUtil.reloadLabelResource(Constants.RELOAD_SOURCE_LABEL);
        return "1";
    }

    @RequestMapping("/saveAttachFile")
    public HashMap saveAttachFile(HttpServletRequest Request) {

        return null;
    }

    @RequestMapping("/getAttachFile")
    public HashMap getAttachFile(HttpServletRequest Request) {

        return null;
    }
    @RequestMapping("/importExcelFile")
    public HashMap importExcelFile(HttpServletRequest Request) {

        return null;
    }
    @RequestMapping("/mysql/exportExcelFile")
    public HashMap exportExcelFile1(HttpServletRequest Request) {

        return null;
    }

    @RequestMapping("/postgre/exportExcelFile")
    public HashMap exportExcelFile2(HttpServletRequest Request) {

        return null;
    }

    @RequestMapping(value = "/mysql/exportReport", method = RequestMethod.POST)
    public ModelAndView exportReport1(Parameters params) {
        HashMap reportData = ReportUtil.getReportData(params, Constants.MYSQL_DATA_SOURCE_BEAN);
        return makeReport(reportData,"pdfReportView");
    }

    @RequestMapping(value = "/postgre/exportReport", method = RequestMethod.POST)
    public ModelAndView exportReport2(Parameters params) {
        HashMap reportData = ReportUtil.getReportData(params, Constants.POSTGRE_DATA_SOURCE_BEAN);
        return makeReport(reportData,"pdfReportView");
    }

    private ModelAndView makeReport(HashMap reportData, String reportViewer) {
        ModelAndView pav = new ModelAndView(reportViewer);
        pav.addObject(Constants.REPORT_PARAM_NAME, reportData.get(Constants.REPORT_PARAM_NAME));
        pav.addObject(Constants.REPORT_PARAM_DATA, reportData.get(Constants.REPORT_PARAM_DATA));
        pav.addObject(Constants.REPORT_PARAM_PARAMETERS, reportData.get(Constants.REPORT_PARAM_PARAMETERS));
        pav.addObject(Constants.REPORT_PARAM_COLUMN, reportData.get(Constants.REPORT_PARAM_COLUMN));
        return pav;
    }
}
