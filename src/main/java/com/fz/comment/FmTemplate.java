package com.fz.comment;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;  
import freemarker.template.TemplateException;

/**
 * freemarker 模版
  */
public class FmTemplate {
  
    private static Configuration configuration = null;
    private static String path;
    static {
        configuration = new Configuration();  
        configuration.setDefaultEncoding("utf-8");
        path=FmTemplate.class.getResource("/").getPath().replaceAll("WEB-INF/classes", "upload/template");
        try {
            configuration.setDirectoryForTemplateLoading(new File(path));
        } catch (IOException e2) {
            // TODO Auto-generated catch block
            e2.printStackTrace();
        }
    }

    /**
     * 替换字符串里面的变量
     * @param templateString
     * @return
     */
    public static String template(String templateString, HashMap map) throws TemplateException, IOException{
        StringWriter result = new StringWriter();
        Template t = new Template("name1", new StringReader(templateString), new Configuration());
        t.process(map, result);
        return  result.toString();
    }

  
    public static void createExcel(HashMap dataMap,String templateName,String filename)  {

        Template t=null;  
        try {  
            //.xml为要装载的模板
            t = configuration.getTemplate(templateName);
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        //输出文档路径及名称  
        Writer out = null;  
		File outFile = new File(path.replace("/template",""), filename);
        if (!outFile.getParentFile().exists()) {//判断父目录路径是否存在，即test.txt前的I:\a\b\
            try {
                outFile.getParentFile().mkdirs();//不存在则创建父目录
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        FileOutputStream fos=null;
        try {  
            fos = new FileOutputStream(outFile);
            OutputStreamWriter oWriter = new OutputStreamWriter(fos,"UTF-8");
            out = new BufferedWriter(oWriter);
        } catch (Exception e1) {  
            e1.printStackTrace();  
        }  
        try {  
            t.process(dataMap, out);  
            out.close();  
            //fos.close(); 
        } catch (TemplateException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
    }
}  