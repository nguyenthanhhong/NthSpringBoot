package com.nth.standard.common.model;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;

/**
 * @class Parameters
 * @author Hong Nguyen
 * @version 1.0
 */
public class Parameters {
    private Locale locale = null;
    private Object data;
    private String errorCode = "0"; // 0: success !0: have error
    private String errorMessage = "";

    public Locale getLocale() {
        return locale;
    }

    public void setLocale(Locale locale) {
        this.locale = locale;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public void setVariables(HashMap data) {
        this.data = data.get("data");
    }
    public void setVariables(int flag) {
        this.data = flag;
    }

    public void setVariables(List<HashMap> data) {
        HashMap tmp = new HashMap();
        tmp.put("data",data);
        this.data = tmp.get("data");
    }

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
}
