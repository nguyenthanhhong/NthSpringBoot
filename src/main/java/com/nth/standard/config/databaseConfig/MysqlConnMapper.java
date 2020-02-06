package com.nth.standard.config.databaseConfig;

import org.springframework.stereotype.Component;

import java.lang.annotation.*;

/**
 * @class MysqlConnMapper
 * @author Hong Nguyen
 * @version 1.0
 */
@Target({ ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Component
public @interface MysqlConnMapper {
    String value() default "";
}

