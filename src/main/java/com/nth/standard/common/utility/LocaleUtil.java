package com.nth.standard.common.utility;

import com.nth.standard.common.model.Config;

import javax.servlet.http.HttpSession;

/**
 * @class LocaleUtil
 * @author Hong Nguyen
 * @version 1.0
 */
public class LocaleUtil {
    public static final String DEFAULT_LANG = resolveDefaultLanguage();
    private static String resolveDefaultLanguage() {
        return Config.getValue("locale.defaultLang");
    }
    public static String getDefaultLanguage() {
        return DEFAULT_LANG;
    }
    public static String getUserLanguage(HttpSession session) {
        if(session == null) {
            return getDefaultLanguage();
        }
        Object lang = session.getAttribute("u_langCd");
        return ((lang != null) ? (String)lang : getDefaultLanguage());
    }
}
