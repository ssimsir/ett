package com.ett.common.util;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonBeanProcessor;

 public class HibernateJsonBeanProcessor implements JsonBeanProcessor {  
     public JSONObject processBean(Object obj, JsonConfig jsonConfig) {  
     return new JSONObject();  
     }  
 }  