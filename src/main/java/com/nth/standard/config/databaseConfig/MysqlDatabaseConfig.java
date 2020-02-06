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
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

/**
 * @class MysqlDatabaseConfig
 * @author Hong Nguyen
 * @version 1.0
 */
@Configuration
@MapperScan(value="com.nth.standard.mapper.MySQLMapper", annotationClass=MysqlConnMapper.class, sqlSessionFactoryRef="mySqlSessionFactory")
@EnableTransactionManagement
public class MysqlDatabaseConfig {
    @Bean(name = "mySqlDataSource", destroyMethod = "close")
    @Primary
    @ConfigurationProperties(prefix = "spring.datasource")
    public DataSource mySqlDataSource() {
        return DataSourceBuilder.create().type(HikariDataSource.class).build();
    }

    @Bean(name = "mySqlSessionFactory")
    @Primary
    public SqlSessionFactory mySqlSessionFactory(@Qualifier("mySqlDataSource") DataSource mySqlDataSource, ApplicationContext applicationContext) throws Exception {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(mySqlDataSource);
        sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath*:sql/**/*.sql"));
        return sqlSessionFactoryBean.getObject();
    }

    @Bean(name = "mySqlSessionTemplate")
    @Primary
    public SqlSessionTemplate mySqlSessionTemplate(SqlSessionFactory mySqlSessionFactory) throws Exception {
        return new SqlSessionTemplate(mySqlSessionFactory);
    }
}
