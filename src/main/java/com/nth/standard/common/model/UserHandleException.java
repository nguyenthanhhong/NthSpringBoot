package com.nth.standard.common.model;

import com.nth.standard.common.utility.MessageUtil;

import java.util.Locale;

/**
 * @class UserHandleException
 * @author Hong Nguyen
 * @version 1.0
 */
public class UserHandleException extends RuntimeException {
    private String errorCode;
    private String errorMessage;
    public UserHandleException(Throwable throwable) {
        super(throwable);
    }

    public UserHandleException(String errorCode) {
        super(errorCode);
        this.errorCode = errorCode;
        this.errorMessage = MessageUtil.getMessage(errorCode);
    }

    public UserHandleException(String errorCode, Throwable throwable) {
        super(errorCode, throwable);
        this.errorCode = errorCode;
        this.errorMessage = MessageUtil.getMessage(errorCode);
    }

    public UserHandleException(String errorCode, Object[] args) {
        super(errorCode);
        this.errorCode = errorCode;
        this.errorMessage = MessageUtil.getMessage(errorCode, args);
    }

    public UserHandleException(String errorCode, Object[] args, Throwable throwable) {
        super(errorCode, throwable);
        this.errorCode = errorCode;
        this.errorMessage = MessageUtil.getMessage(errorCode, args);
    }

    public String getErrorCode() {
        return this.errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }

    public String getErrorMessage() {
        return this.errorMessage;
    }

    public String getErrorMessage(Locale locale) {
        return MessageUtil.getMessage(this.errorCode, null, locale);
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
}
