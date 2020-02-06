package com.nth.standard.common.model;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nth.standard.common.utility.Constants;
import com.nth.standard.common.utility.StringUtil;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.util.*;

/**
 * @class ParametersArgumentResolver
 * @author Hong Nguyen
 * @version 1.0
 */
public class ParametersArgumentResolver implements HandlerMethodArgumentResolver {
    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        return parameter.getParameterType().equals(Parameters.class);
    }

    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
        HttpServletRequest request = webRequest.getNativeRequest(HttpServletRequest.class);

        HttpServletRequest requestInfo = (HttpServletRequest)webRequest.getNativeRequest();
        String contentType = request.getContentType();
        HashMap inParams = new HashMap();
        HttpSession session = ((HttpServletRequest)request).getSession();
        //inParams.setLocale(LocaleUtil.getUserLocale(session));

        String userId = session.getAttribute("u_userId").toString();
        String langCd = session.getAttribute("u_langCd").toString();
        //get session params set to parameter
        /*Enumeration attrNames = session.getAttributeNames();
        while(attrNames.hasMoreElements()) {
            String attrName = (String)attrNames.nextElement();
            inParams.setVariable(attrName, session.getAttribute(attrName));
        }*/

        //get parameter from request
        //ContentType: application/x-www-form-urlencoded
        HashMap params = new HashMap();
        Map<String, String[]> paramMap = webRequest.getParameterMap();
        Iterator it = paramMap.keySet().iterator();
        while(it.hasNext()) {
            Object key = it.next();
            String[] value = paramMap.get(key);
            if(Constants.REPORT_PARAM_DATA.equals(key)){
                Object rpData = StringUtil.parseJSONString(value[0]);
                if(rpData instanceof List){
                    List<HashMap> jsonMap = (List<HashMap>)rpData;
                    for(HashMap item : jsonMap){
                        item.put("u_userId",userId);
                        item.put("u_langCd",langCd);
                    }
                    params.put(key.toString(), jsonMap);
                    continue;
                }
                if(rpData instanceof HashMap){
                    HashMap jsonStr = (HashMap)rpData;
                    jsonStr.put("u_userId",userId);
                    jsonStr.put("u_langCd",langCd);
                    params.put(key.toString(), jsonStr);
                    continue;
                }
            }
            params.put(key.toString(),value[0]);
        }

        //ContentType: application/json
        if(contentType.contains("application/json")) {
            webRequest.setAttribute("contentType", "application/json", 0);
            StringBuilder jsonText = new StringBuilder();
            String line = null;
            ObjectMapper mapper = new ObjectMapper();
            try {
                BufferedReader reader = requestInfo.getReader();
                while((line = reader.readLine()) != null) {
                    jsonText.append(line);
                }
                JsonNode tree = mapper.readTree(jsonText.toString());
                if(tree.isArray()) {
                    List<HashMap> jsonMap = mapper.readValue(jsonText.toString(), new TypeReference<List<HashMap>>() {});
                    for(HashMap item : jsonMap){
                        item.put("u_userId",userId);
                        item.put("u_langCd",langCd);
                    }
                    inParams.put("data", jsonMap);
                } else {
                    Map<String, Object> jsonMap = mapper.readValue(jsonText.toString(), new TypeReference<Map<String, Object>>() {});
                    String objKey;
                    Object objValue;
                    HashMap childParams = new HashMap();

                    for(Map.Entry<String, Object> e : jsonMap.entrySet()) {
                        objKey = (String)e.getKey();
                        objValue = e.getValue();
                        if (objValue instanceof List<?>) {
                            List<HashMap> list = (List<HashMap>) objValue;
                            for(HashMap item : list){
                                item.put("u_userId",userId);
                                item.put("u_langCd",langCd);
                            }
                            childParams.put(objKey,list);
                        } else {
                            childParams.put(objKey,objValue);
                        }
                    }

                    childParams.put("u_userId",userId);
                    childParams.put("u_langCd",langCd);
                    inParams.put("data", childParams);
                }
            } catch(Exception e) {
                throw new UserHandleException(e);
            }
        }

        Parameters cr = new Parameters();

        if(inParams.get("data")!=null) {
            params.putAll((HashMap) inParams.get("data"));
        }
        cr.setData(params);
        return cr;
    }
}

