package com.nth.standard.common.tag;

import com.nth.standard.common.model.UserHandleException;
import com.nth.standard.common.utility.CommonCodeUtil;
import com.nth.standard.common.utility.HTMLElementUtil;
import com.nth.standard.common.utility.StringUtil;
import lombok.Getter;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.util.TagUtils;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @class CodeListTag
 * @author Hong Nguyen
 * @version 1.0
 */
@Getter
@Setter
public class CodeListTag  extends TagSupport {
    private static final Logger LOG = LoggerFactory.getLogger(CodeListTag.class);
    private static final String CODE = "CODE_CD";
    private static final String NAME = "CODE_NM";
    private static final String OUT_TYPE_RADIO = "radio";
    private static final String OUT_TYPE_CHECK = "checkbox";
    private static final String OUT_TYPE_SELECT = "select";
    private static final String OUT_TYPE_VAR = "var";
    private static final String OUT_TYPE_LIST = "list";

    private String cmCd;
    private String outType;
    private String id;
    private String name;
    private String selectDefaultName;
    private String selectDefaultValue;
    private String multiple;
    private String selectedValue;
    private String cssClass;
    private String cssStyle;
    private String cssGroup = "";
    private String var;
    private String scope = TagUtils.SCOPE_PAGE;
    private String required;
    private String onchange;
    private String isReadOnly = "false";
    @Override
    public int doEndTag() throws JspException {
        try {
            HttpSession session = pageContext.getSession();
            String langCd = (String)session.getAttribute("u_langCd");
            List<HashMap> dataList = CommonCodeUtil.getCodeList(this.cmCd, langCd);
            StringBuilder html = null;

            List selectedValueList = resolveArguments(selectedValue);

            switch (this.outType) {
                case OUT_TYPE_VAR:
                    if(StringUtil.isEmpty(this.var)) {
                        throw new UserHandleException("NO_VALUE_FOUND");
                    }
                    pageContext.setAttribute(this.var, dataList, TagUtils.getScope(this.scope));
                    break;
                case OUT_TYPE_LIST:
                    html = new StringBuilder();
                    html.append("[");
                    String codeList = dataList.stream()
                            .map(node-> makeListCode(node))
                            .collect(Collectors.joining(", "));
                    html.append(codeList);
                    html.append("]");
                    pageContext.getOut().write(html.toString());
                    break;
                case OUT_TYPE_RADIO:
                case OUT_TYPE_CHECK:
                    html = createRadioOrCheckbox(dataList, this.outType, selectedValueList);
                    pageContext.getOut().write(html.toString());
                    break;
                case OUT_TYPE_SELECT:
                    html = createSelectBox(dataList);
                    pageContext.getOut().write(html.toString());
                    break;
            }

        } catch(RuntimeException ex) {
            LOG.error(ex.getMessage(), ex);
            throw ex;
        } catch(Exception ex) {
            LOG.error(ex.getMessage(), ex);
            throw new JspTagException(ex.getMessage());
        }

        return EVAL_PAGE;
    }

    private StringBuilder createSelectBox(List<HashMap> dataList) {
        StringBuilder html = HTMLElementUtil.createSelectBox(this.id,this.name,this.cssClass,this.cssStyle,this.required,this.onchange,this.multiple,this.isReadOnly);

        if(!StringUtils.isEmpty(this.selectDefaultName)) {
            html.append(HTMLElementUtil.createSelectOption(this.selectDefaultValue, this.selectDefaultName));
        }

        if(dataList != null) {
            for (HashMap selectListMap : dataList) {
                html.append(HTMLElementUtil.createSelectOption(selectListMap.get(CODE), selectListMap.get(NAME), selectedValue));
            }
        }
        html.append("</select>");
        return html;
    }

    private StringBuilder createRadioOrCheckbox(List<HashMap> codeListSet,  String tagName, List selectedValueList) throws JspException {
        StringBuilder html;
        html = new StringBuilder();
        String gCss = StringUtil.isEmpty(this.cssGroup) ? "input-group" : this.cssGroup;
        html.append("<div class=\"" + gCss + "\">");
        if(codeListSet != null) {
            int i = 1;
            for (HashMap e : codeListSet) {
                String value = (String) e.get(CODE);
                String title = (String) e.get(NAME);
                String eId = StringUtil.isEmpty(this.id) ? "" : this.id + (i++);
                html.append(HTMLElementUtil.createRadioOrCheckbox(tagName, eId, this.name, this.cssClass, this.cssStyle, this.onchange, this.isReadOnly, this.required, value, title, selectedValueList));
            }
        }
        html.append("</div>");
        return html;
    }

    private List resolveArguments(String arguments) {
        if(arguments == null || arguments.isEmpty()) {
            return null;
        }
        String[] str = org.springframework.util.StringUtils.delimitedListToStringArray(arguments, ",");
        return Arrays.asList(str);
    }

    private String makeListCode(HashMap node){
        return "{\"code\":\"" + node.get(CODE) + "\", \"value\":\"" + node.get(NAME) + "\"}";
    }
}
