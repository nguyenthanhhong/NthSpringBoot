package com.nth.standard.service;

import com.nth.standard.common.context.ContextUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;

/**
 * @class BaseService
 * @author Hong Nguyen
 * @version 1.0
 */
public class BaseService {
    @Autowired
    SqlSessionFactory sqlSessionFactory;
    public void setSqlManager(String BeanName) {
        sqlSessionFactory = (SqlSessionFactory) ContextUtils.getBean(BeanName);
    }
    public Object queryForObject(Object params, String sqlMapperId) {
        SqlSession sqlSession =sqlSessionFactory.openSession();
        Object result = sqlSession.selectOne(sqlMapperId, params);
        sqlSession.close();
        return result;
    }
    public List queryForList(Object params, String sqlMapperId) {
        SqlSession sqlSession =sqlSessionFactory.openSession();
        List result = sqlSession.selectList(sqlMapperId, params);
        sqlSession.close();
        return result;
    }
    public int insert(Object params, String sqlMapperId) {
        SqlSession sqlSession =sqlSessionFactory.openSession();
        int result = 0;
        if (params instanceof List<?>) {
            List<HashMap> list = (List<HashMap>) params;
            for(HashMap item : list){
                result = sqlSession.insert(sqlMapperId, item);
            }
        } else {
            result = sqlSession.insert(sqlMapperId, params);
        }
        sqlSession.close();
        return result;
    }
    public int update(Object params, String sqlMapperId) {
        SqlSession sqlSession =sqlSessionFactory.openSession();
        int result = 0;
        if (params instanceof List<?>) {
            List<HashMap> list = (List<HashMap>) params;
            for(HashMap item : list){
                result = sqlSession.update(sqlMapperId, item);
            }
        } else {
            result = sqlSession.update(sqlMapperId, params);
        }
        sqlSession.close();
        return result;
    }
    public int delete(Object params, String sqlMapperId) {
        SqlSession sqlSession =sqlSessionFactory.openSession();
        int deleteCount = 0;
        if (params instanceof List<?>) {
            List<HashMap> list = (List<HashMap>) params;
            for(HashMap item : list){
                deleteCount = sqlSession.delete(sqlMapperId, item);
            }
        } else {
            deleteCount = sqlSession.delete(sqlMapperId, params);
        }
        sqlSession.close();
        return deleteCount;
    }

    public Object callSp(Object params, String sqlMapperId) {
        SqlSession sqlSession =sqlSessionFactory.openSession();
        HashMap result = new HashMap<>();
        if (params instanceof List<?>) {
            List<HashMap> list = (List<HashMap>) params;
            for(HashMap item : list){
                item.put("O_RET","");
                item.put("O_MSG_CD","");
                sqlSession.insert(sqlMapperId, item);
                result = item;
            }
        } else {
            result = (HashMap) params;
            result.put("O_RET","");
            result.put("O_MSG_CD","");
            sqlSession.insert(sqlMapperId, result);
        }
        sqlSession.close();
        return result;
    }
}
