package com.nth.standard.common.context;

import org.springframework.context.ApplicationContext;

/**
 * @class ContextUtils
 * @author Hong Nguyen
 * @version 1.0
 */
public class ContextUtils {
    private static ApplicationContext applicationContext;

    public static ApplicationContext getApplicationContext() {
        synchronized (ContextUtils.class) {
            while (applicationContext == null) {
                try {
                    ContextUtils.class.wait(60000);
                    if (applicationContext == null) {
                        //log.warn("Have been waiting for ApplicationContext to be set for 1 minute", new Exception());
                    }
                } catch (InterruptedException ex) {
                    //log.debug("getApplicationContext, wait interrupted");
                }
            }
            return applicationContext;
        }
    }

    public static Object getBean(Class<?> beanType) {
        return getApplicationContext().getBean(beanType);
    }

    public static Object getBean(String name) {
        return getApplicationContext().getBean(name);
    }

    protected static void setApplicationContext(ApplicationContext applicationContext) {
        synchronized (ContextUtils.class) {
            ContextUtils.applicationContext = applicationContext;
            ContextUtils.class.notifyAll();
        }
    }
}
