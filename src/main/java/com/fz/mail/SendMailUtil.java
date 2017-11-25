package com.fz.mail;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.util.Properties;

/**
 * Created by Administrator on 2017/9/22.
 */
public class SendMailUtil {

    public static Properties properties;
    public static Properties getEmailInfo(String path) throws  Exception{
        synchronized (SendMailUtil.class){
            if(properties==null){
                synchronized (SendMailUtil.class){
                    properties = new Properties();
                    FileInputStream fis = new FileInputStream(new File(path));
                    properties.load(fis);
                    return  properties;
                }
            }else{
                return  properties;
            }
        }
    }
    public static Integer getInteger(String key){
        return  Integer.parseInt(properties.getProperty(key));
    }
    public static String getString(String key){
        return  properties.getProperty(key);
    }
    public static Double getDouble(String key){
        return  Double.parseDouble(properties.getProperty(key));
    }
}
