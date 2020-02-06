package com.nth.standard.config;

import com.nth.standard.common.model.ParametersArgumentResolver;
import com.nth.standard.mapper.MySQLMapper.MessageResourceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;

import java.util.List;
import java.util.Locale;

/**
 * @class MvcConfig
 * @author Hong Nguyen
 * @version 1.0
 */
@Configuration
public class MvcConfig implements WebMvcConfigurer {
    @Autowired
    MessageResourceMapper messageResourceMapper;
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/template/**").addResourceLocations("/WEB-INF/template/");
        registry.addResourceHandler("/**").addResourceLocations("/WEB-INF/resources/");
    }
    @Bean
    public LocaleResolver localeResolver() {
        CookieLocaleResolver lr = new CookieLocaleResolver();
        lr.setDefaultLocale(Locale.US);
        return lr;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
        localeChangeInterceptor.setParamName("lang");
        registry.addInterceptor(localeChangeInterceptor);
    }
    @Bean
    DBMessageSource messageSource(){
        DBMessageSource databaseDrivenMessageSource = new DBMessageSource(messageResourceMapper);
        //databaseDrivenMessageSource.setCacheSeconds(100); //reload messages every 100 seconds
        return databaseDrivenMessageSource;
    }

    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
        argumentResolvers.add(new ParametersArgumentResolver());
    }
}