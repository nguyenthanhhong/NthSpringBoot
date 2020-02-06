package com.nth.standard.config.databaseConfig;

import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.*;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

/**
 * @class PostgreDatabaseConfig
 * @author Hong Nguyen
 * @version 1.0
 */
@Configuration
@MapperScan(value="com.nth.standard.mapper.PostgreMapper", annotationClass=PostgreConnMapper.class, sqlSessionFactoryRef="postgreSqlSessionFactory")
@EnableTransactionManagement
public class PostgreDatabaseConfig {
    @Bean(name = "postgreDataSource", destroyMethod = "close")
    @ConfigurationProperties(prefix = "spring.postgresql.datasource")
    public DataSource postgreDataSource() {
        return DataSourceBuilder.create().type(HikariDataSource.class).build();
    }

    @Bean(name = "postgreSqlSessionFactory")
    public SqlSessionFactory postgreSqlSessionFactory(@Qualifier("postgreDataSource") DataSource postgreDataSource, ApplicationContext applicationContext) throws Exception {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(postgreDataSource);
        sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath*:sql/**/*.sql"));
        return sqlSessionFactoryBean.getObject();
    }

    @Bean(name = "postgreSqlSessionTemplate")
    public SqlSessionTemplate postgreSqlSessionTemplate(SqlSessionFactory postgreSqlSessionFactory) throws Exception {
        return new SqlSessionTemplate(postgreSqlSessionFactory);
    }
}
