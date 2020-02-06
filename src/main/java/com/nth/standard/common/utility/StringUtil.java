package com.nth.standard.common.utility;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @class StringUtil
 * @author Hong Nguyen
 * @version 1.0
 */
public class StringUtil {
    public static String getJSONString(Object obj) {
        String ret = null;
        try {
            ObjectMapper mapper = new ObjectMapper();
            ret = mapper.writeValueAsString(obj);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return ret;
    }
    public static Object parseJSONString(String obj) {
        try {
            final ObjectMapper mapper = new ObjectMapper();
            JsonNode tree = mapper.readTree(obj);
            if(tree.isArray()) {
                return mapper.readValue(obj, new TypeReference<List<HashMap>>() {});
            } else {
                return mapper.readValue(obj, new TypeReference<Map<String, Object>>() {});
            }
        } catch (IOException e) {
            return obj;
        }
    }
    public static String toString(Object obj) {
        return (obj == null ? "" : obj.toString());
    }
    public static String nvl(String obj, String s) {
        return (obj == null ? s : obj);
    }
    public static String nvl(Object obj, String s) {
        if (obj == null)
            return s;
        return (obj.toString().isEmpty() ? s : obj.toString());
    }
    public static String nvl(Object obj, Object s) {
        if (obj == null && s == null)
            return "";
        if (obj == null)
            return toString(s);
        return (obj.toString().isEmpty() ? toString(s) : obj.toString());
    }
    public static boolean isEmpty(Object obj) {
        return (obj == null ? true : obj.toString().isEmpty());
    }
}
