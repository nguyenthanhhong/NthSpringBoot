package com.nth.standard.common.tag;

import com.nth.standard.common.model.UserHandleException;
import com.nth.standard.common.utility.StringUtil;
import com.nth.standard.service.BaseService;
import lombok.Getter;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.*;

/**
 * @class SelectTag
 * @author Hong Nguyen
 * @version 1.0
 */
@Getter
@Setter
public class SelectTag  extends TagSupport {
    private static final Logger LOG = LoggerFactory.getLogger(SelectTag.class);
    private static final String CODE = "CODE";
    private static final String NAME = "NAME";
    private static final String DEFAULT_QUERY = "getCommonCodeList";
    private String id;
    private String name;
    private String sqlId;
    private String params;
    private String selectedValue;
    private String cssClass;
    private String cssStyle;
    private String required;
    private String onChange;
    private String attrOpts;
    private String isReadOnly = "false";
    private String selectDefaultName;
    private String selectDefaultValue;
    private String multiple;
    private String outType = "";
    @Override
    public int doEndTag() throws JspException {

        try {
            HttpSession session = pageContext.getSession();
            HashMap inParams = new HashMap();

            if(this.sqlId == null) {
                this.sqlId = DEFAULT_QUERY;
            }

            inParams.put("sqlId", this.sqlId);

            if(this.params != null) {
                String[] paramArr = params.split("\\|");
                for(int i = 0; i < paramArr.length; i++) {
                    if(paramArr[i].indexOf("!") > -1) {
                        String[] subParamArr = paramArr[i].split("\\!");
                        inParams.put("param" + (i + 1), subParamArr);
                    } else {
                        inParams.put("param" + (i + 1), paramArr[i]);
                    }
                }
            }

            Enumeration e = session.getAttributeNames();
            String sessionName = null;
            String sessionValue = null;
            while(e.hasMoreElements()) {
                sessionName = StringUtil.toString((String)e.nextElement());
                if(!sessionName.contains("u_")) {
                    continue;
                }
                sessionValue = StringUtil.toString((String)session.getAttribute(sessionName));
                inParams.put(sessionName, sessionValue);
            }

            BaseService service = new BaseService();
            service.setSqlManager("mySqlSessionFactory");
            List<HashMap> rstSelectList = service.queryForList(inParams, "ComboBoxService." + inParams.get("sqlId"));

            String html = makeSelectElement(rstSelectList);

            pageContext.getOut().write(html);

        } catch(RuntimeException ex) {
            LOG.error(ex.getMessage(), ex);
            throw ex;
        } catch(Exception ex) {
            LOG.error(ex.getMessage(), ex);
            throw new JspTagException(ex.getMessage());
        }

        return EVAL_PAGE;
    }

    private String makeSelectElement(List<HashMap> rstSelectList) {
        StringBuffer htmlSb = new StringBuffer();

        htmlSb.append("<select");
        if(!StringUtils.isEmpty(this.id)) {
            htmlSb.append(" id='").append(this.id).append("'");
        }
        if(!StringUtils.isEmpty(this.name)) {
            htmlSb.append(" name='").append(this.name).append("'");
        }
        if(!StringUtils.isEmpty(this.cssClass)) {
            htmlSb.append(" class='").append(this.cssClass).append("'");
        }
        if(!StringUtils.isEmpty(this.cssStyle)) {
            htmlSb.append(" style='").append(this.cssStyle).append("'");
        }
        if(!StringUtils.isEmpty(this.required)) {
            htmlSb.append(" required");
        }
        if(!StringUtils.isEmpty(this.onChange)) {
            htmlSb.append(" onchange='").append(this.onChange).append("'");
        }
        if(!StringUtils.isEmpty(this.multiple)) {
            htmlSb.append(" multiple='").append(this.multiple).append("'");
        }
        if(Boolean.parseBoolean(this.isReadOnly)) {
            htmlSb.append(" readonly ");
        }

        htmlSb.append(">");

        String resolvedSelectDefaultName = this.selectDefaultName;
        String resolvedSelectDefaultValue = StringUtil.toString(this.selectDefaultValue);

        if(!StringUtils.isEmpty(resolvedSelectDefaultName)) {
            htmlSb.append("<option value=\"").append(StringUtil.toString(resolvedSelectDefaultValue)).append("\">").append(resolvedSelectDefaultName).append("</option>");
        }

        if(rstSelectList != null && rstSelectList.size() > 0) {
            boolean isAddOpts = false;
            Set<String> keys = null;
            if(!rstSelectList.get(0).containsKey(NAME) || !rstSelectList.get(0).containsKey(CODE)) {
                throw new UserHandleException("**** NAME, CODE IS MANDANTORY *****");
            } else {
                isAddOpts = rstSelectList.get(0).keySet().size() > 2 ? true : false;
                keys = rstSelectList.get(0).keySet();
            }

            for(Map<String, Object> selectListMap : rstSelectList) {
                htmlSb.append("<option value='").append(selectListMap.get(CODE)).append("'");
                if(isAddOpts) {
                    for(String key : keys) {
                        if((!NAME.equals(key) && !CODE.equals(key)) && selectListMap.get(key) != null) {
                            htmlSb.append(" ").append(key).append("='").append(selectListMap.get(key)).append("'");
                        }
                    }
                }
                if(selectedValue != null && selectedValue.equals(selectListMap.get(CODE))) {
                    htmlSb.append(" selected");
                }

                htmlSb.append("/>");
                htmlSb.append(selectListMap.get(NAME));
                htmlSb.append("</option>");
            }
        }
        htmlSb.append("</select>");

        return htmlSb.toString();
    }
}
