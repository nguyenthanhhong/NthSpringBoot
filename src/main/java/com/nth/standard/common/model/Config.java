package com.nth.standard.common.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

/**
 * @class Config
 * @author Hong Nguyen
 * @version 1.0
 */
@Component
public class Config {
    private static Environment env;
    @Autowired
    public Config(Environment env) {
        Config.env = env;
    }

    public static String getValue(String key){
        return env.getProperty(key);
    }

    public static String[] getUploadConfig(){
        String limit = env.getProperty("upload.config.limit");
        String extention = env.getProperty("upload.config.extention");
        return new String[]{limit,extention};
    }
    public static String getUploadRootDir() {
        return env.getProperty("upload.dir");
    }
}
