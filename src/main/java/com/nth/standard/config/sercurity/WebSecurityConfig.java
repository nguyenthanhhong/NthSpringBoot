package com.nth.standard.config.sercurity;

import com.nth.standard.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDecisionVoter;
import org.springframework.security.access.vote.UnanimousBased;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.access.expression.WebExpressionVoter;

import java.util.ArrayList;
import java.util.List;

/**
 * @class WebSecurityConfig
 * @author Hong Nguyen
 * @version 1.0
 */
@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    UserService userDetailsService;

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        return bCryptPasswordEncoder;
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        // Setting Service to find User in the database.
        // And Setting PassswordEncoder
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        String roleNames = "hasAnyRole(" + userDetailsService.getAllRoles() + ")" ;


        // Disable CSRF (cross site request forgery)
        http.csrf().disable();
        // Config for Login Form
        http
            .headers()
                .frameOptions().sameOrigin()//allow use of frame to same origin urls
                .and()
            .authorizeRequests()
                .antMatchers("/mysql/**")
                .authenticated()
                .antMatchers("/postgre/**")
                .authenticated()
                .antMatchers("/","/main/**","/favicon.ico")
                .authenticated()
                // The pages does not require login
                .antMatchers("/login", "/logout", "/signup").permitAll()
                .antMatchers("/webjars/**", "/plugin/**", "/fonts/**", "/css/**", "/js/**", "/images/**").permitAll()
                .anyRequest().access("hasAnyRole(" + roleNames + ")")
                .and()
            .formLogin()
                .loginProcessingUrl("/j_spring_security_check") // Submit URL
                .loginPage("/login")
                .defaultSuccessUrl("/main/signinsucessfully")
                .failureUrl("/login?error=true")
                .usernameParameter("username")
                .passwordParameter("password")
                //.failureHandler(customAuthenticationFailureHandler())
                .and()
            .logout()
                .clearAuthentication(true)
                .logoutUrl("/logout")
                .logoutSuccessUrl("/logoutSuccessful")
                .permitAll()
                .deleteCookies("JSESSIONID")
        ;

        // When the user has logged in as XX.
        // But access a page that requires role YY,
        // AccessDeniedException will be thrown.
        http.authorizeRequests().and().exceptionHandling().accessDeniedPage("/403");
    }
}
