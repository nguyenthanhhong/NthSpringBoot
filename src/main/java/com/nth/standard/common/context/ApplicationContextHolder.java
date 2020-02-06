package com.nth.standard.common.context;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

/**
 * @class ApplicationContextHolder
 * @author Hong Nguyen
 * @version 1.0
 */
@Component
public class ApplicationContextHolder implements ApplicationContextAware {
    @Override
    public void setApplicationContext(ApplicationContext ctx) throws BeansException {
        ContextUtils.setApplicationContext(ctx);
    }
}
