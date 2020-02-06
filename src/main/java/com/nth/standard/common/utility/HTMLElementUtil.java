package com.nth.standard.common.utility;

import org.springframework.util.StringUtils;

import javax.servlet.jsp.JspException;
import java.util.List;

/**
 * @class HTMLElementUtil
 * @author Hong Nguyen
 * @version 1.0
 */
public class HTMLElementUtil {
    public static StringBuilder createSelectBox(String id, String name, String cssClass, String cssStyle, String required, String onchange, String multiple, String isReadOnly){
        StringBuilder html = new StringBuilder();
        html.append("<select");
        if(!StringUtils.isEmpty(id)) {
            html.append(" id='").append(id).append("'");
        }
        if(!StringUtils.isEmpty(name)) {
            html.append(" name='").append(name).append("'");
        }
        if(!StringUtils.isEmpty(cssClass)) {
            html.append(" class='").append(cssClass).append("'");
        }
        if(!StringUtils.isEmpty(cssStyle)) {
            html.append(" style='").append(cssStyle).append("'");
        }
        if(!StringUtils.isEmpty(required)) {
            html.append(" required");
        }
        if(!StringUtils.isEmpty(onchange)) {
            html.append(" onchange='").append(onchange).append("'");
        }
        if(!StringUtils.isEmpty(multiple)) {
            html.append(" multiple='").append(multiple).append("'");
        }
        if(Boolean.parseBoolean(isReadOnly)) {
            html.append(" readonly ");
        }

        html.append(">");
        return html;
    }
    public static StringBuilder createSelectOption(Object value, Object title){
        return createSelectOption(value, title, null);
    }
    public static StringBuilder createSelectOption(Object value, Object title, Object selectedValue){
        value = value == null ? "" : value;
        StringBuilder html;
        html = new StringBuilder();
        html.append("<option value='").append(value).append("'");
        if(selectedValue != null && selectedValue.equals(value)) {
            html.append(" selected");
        }

        html.append(">");
        html.append(title);
        html.append("</option>");
        return html;
    }
    public static StringBuilder createRadioOrCheckbox(String elementType, String elementId, String elementName, String cssClass, String cssStyle, String onchange, String isReadOnly, String isRequired, Object value, Object title, List selectedValueList) throws JspException {
        StringBuilder html = new StringBuilder("<label ");

        if(!StringUtil.isEmpty(cssClass)) {
            html.append("class=\"").append(cssClass).append("\" ");
        }

        if(!StringUtil.isEmpty(cssStyle)) {
            html.append("style=\"").append(cssStyle).append("\" ");
        }

        html.append("><input type=\"" + elementType + "\" ");

        if(!StringUtil.isEmpty(elementId)) {
            html.append("id=\"").append(elementId).append("\" ");
        }
        if(!StringUtil.isEmpty(elementName)) {
            html.append("name=\"").append(elementName).append("\" ");
        }
        if(!StringUtil.isEmpty(value)) {
            html.append("value=\"").append(value).append("\" ");
        }
        if(!StringUtil.isEmpty(onchange)) {
            html.append(" onchange=\"").append(onchange).append("\" ");
        }
        if(selectedValueList != null && selectedValueList.contains(value)) {
            html.append("checked=\"checked\" ");
        }
        if(Boolean.parseBoolean(isReadOnly)) {
            html.append(" readonly ");
        }
        if(Boolean.parseBoolean(isRequired)) {
            html.append(" required ");
        }
        html.append("><span></span>"+ title + "</label>");

        return html;
    }
}
