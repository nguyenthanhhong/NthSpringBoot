package com.nth.standard.common.utility;

import com.nth.standard.common.context.ContextUtils;
import com.nth.standard.config.DBMessageSource;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.MessageSource;
import org.springframework.context.NoSuchMessageException;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.DelegatingMessageSource;

import java.util.Locale;

/**
 * @class MessageUtil
 * @author Hong Nguyen
 * @version 1.0
 */
public class MessageUtil {
    private static MessageSource messageSource;

    public static String getMessage(String key) {
        try {
            if(messageSource == null) {
                messageSource = (MessageSource)ContextUtils.getBean("messageSource");
            }
            return messageSource.getMessage(key, null, LocaleContextHolder.getLocale());
        } catch(NoSuchMessageException e) {
            e.printStackTrace();
        }
        return "MESSAGE_NOT_FOUND";
    }

    public static String getMessage(String key, Object[] args) {
        try {
            if(messageSource == null) {
                messageSource = (MessageSource)ContextUtils.getBean("messageSource");
            }
            return messageSource.getMessage(key, args, LocaleContextHolder.getLocale());
        } catch(NoSuchMessageException e) {
            e.printStackTrace();
        }
        return "MESSAGE_NOT_FOUND";
    }

    public static String getMessage(String key, Locale locale) {
        try {
            if(messageSource == null) {
                messageSource = (MessageSource)ContextUtils.getBean("messageSource");
            }
            return messageSource.getMessage(key, null, locale);
        } catch(NoSuchMessageException e) {
            e.printStackTrace();
        }
        return "MESSAGE_NOT_FOUND";
    }

    public static String getMessage(String key, Object[] args, Locale locale) {
        try {
            if(messageSource == null) {
                messageSource = (MessageSource)ContextUtils.getBean("messageSource");
            }
            return messageSource.getMessage(key, args, locale);
        } catch(NoSuchMessageException e) {
            e.printStackTrace();
        }
        return "MESSAGE_NOT_FOUND";
    }

    public static void reloadLabelResource(String type) {
        try {
            if(messageSource == null) {
                messageSource = (MessageSource)ContextUtils.getBean("messageSource");
            }

            if (messageSource instanceof DBMessageSource) {
                ((DBMessageSource)messageSource).reloadResource(type);

            } else if (messageSource instanceof DelegatingMessageSource) {
                DelegatingMessageSource myMessage = ((DelegatingMessageSource)messageSource);
                if (myMessage.getParentMessageSource()!=null && myMessage.getParentMessageSource() instanceof DBMessageSource) {
                    ((DBMessageSource) myMessage.getParentMessageSource()).reloadResource(type);
                }
            }
        } catch(NoSuchMessageException e) {
            e.printStackTrace();
        }
    }
}
