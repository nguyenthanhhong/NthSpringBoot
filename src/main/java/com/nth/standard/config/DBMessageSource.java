package com.nth.standard.config;

import com.nth.standard.common.utility.Constants;
import com.nth.standard.common.utility.StringUtil;
import com.nth.standard.mapper.MySQLMapper.MessageResourceMapper;
import org.springframework.context.ResourceLoaderAware;
import org.springframework.context.support.AbstractMessageSource;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.ResourceLoader;
import org.springframework.util.StringUtils;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/**
 * @class DBMessageSource
 * @author Hong Nguyen
 * @version 1.0
 */
public class DBMessageSource extends AbstractMessageSource implements ResourceLoaderAware {
    private MessageResourceMapper messageResourceMapper;
    private final HashMap properties = new HashMap();
    private ResourceLoader resourceLoader;

    public DBMessageSource(MessageResourceMapper mapper) {
        this.messageResourceMapper = mapper;
        loadDatabaseResource();
    }

    @Override
    public void setResourceLoader(ResourceLoader resourceLoader) {
        this.resourceLoader = (resourceLoader != null ? resourceLoader : new DefaultResourceLoader());
    }

    @Override
    protected MessageFormat resolveCode(String s, Locale locale) {
        String message = getResourceText(s, locale);
        return new MessageFormat(message, locale);
    }

    @Override
    protected String resolveCodeWithoutArguments(String code, Locale locale) {
        return getResourceText(code, locale);
    }

    private void loadDatabaseResource() {
        properties.clear();
        properties.putAll(loadLabelResource());
        properties.putAll(loadMessageResource());
    }

    public void reloadResource(String type) {
        if(Constants.RELOAD_SOURCE_LABEL.equals(type)) {
            properties.putAll(loadLabelResource());
        } else {
            properties.putAll(loadMessageResource());
        }
    }

    private String getResourceText(String code, Locale locale) {
        String textForCurrentLanguage = StringUtil.toString(properties.get(locale.getLanguage() + "." + code));
        return StringUtils.isEmpty(textForCurrentLanguage) ? code : textForCurrentLanguage;
    }

    private HashMap<String, String> loadLabelResource() {
        HashMap<String, String> m = new HashMap<String, String>();
        List<HashMap> texts = messageResourceMapper.getAllLabel();
        for (HashMap text : texts) {
            Map<String, String> v = new HashMap<String, String>();
            String key = StringUtil.toString(text.get("LABEL_CD"));
            String value = StringUtil.toString(text.get("LABEL_NM"));
            m.put(key, value);
        }
        return m;
    }

    private HashMap<String, String> loadMessageResource(){
        HashMap<String, String> m = new HashMap<String, String>();
        List<HashMap> texts = messageResourceMapper.getAllMessage();
        for (HashMap text : texts) {
            Map<String, String> v = new HashMap<String, String>();
            String key = StringUtil.toString(text.get("MSG_CD"));
            String value = StringUtil.toString(text.get("MSG_NM"));
            m.put(key, value);
        }
        return m;
    }
}
