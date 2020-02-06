package com.nth.standard.config.databaseConfig;

import org.springframework.stereotype.Component;

import java.lang.annotation.*;

/**
 * @class PostgreConnMapper
 * @author Hong Nguyen
 * @version 1.0
 */
@Target({ ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Component
public @interface PostgreConnMapper {
    String value() default "";
}
