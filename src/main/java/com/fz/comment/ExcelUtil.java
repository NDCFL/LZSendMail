package com.fz.comment;

import com.fz.vo.AgencyVo;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class ExcelUtil {
    /* POI:解析Excel文件中的数据并把每行数据封装成一个实体
     * @param fis 文件输入流
     * @return List<AgencyVo> Excel中数据封装实体的集合
     */
    public static List<AgencyVo> importAgencyByPoi(FileInputStream fis){
        List<AgencyVo> infos = new ArrayList<AgencyVo>();
        AgencyVo agencyVo = null;
        try {
            Workbook book = null;
            try {
                book = new XSSFWorkbook(fis);
            } catch (Exception ex) {
                book = new HSSFWorkbook(fis);
            }

            //得到第一个工作表
            Sheet sheet = book.getSheetAt(0);
            Row row = null;
            //日期格式化
            DateFormat ft = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            //遍历该表格中所有的工作表，i表示工作表的数量 getNumberOfSheets表示工作表的总数
            for(int i = 0; i < book.getNumberOfSheets(); i++) {
                sheet = book.getSheetAt(i);
                //遍历该行所有的行,j表示行数 getPhysicalNumberOfRows行的总数
                for(int j =0; j < sheet.getPhysicalNumberOfRows(); j++) {
                    if(j==0){
                        row = sheet.getRow(j);
                        String head = "";
                        for(int h=0;h<3;h++){
                            head+=row.getCell(h);
                        }
                        AgencyVo agencyVo1 = new AgencyVo();
                        if(!head.equals("公司名称法人邮件账号")){
                            agencyVo1.setInfo("请使用正确的模板导入数据!");
                            infos.add(agencyVo1);
                            return infos;
                        }else{
                            continue;
                        }
                    }else{
                        row = sheet.getRow(j);
                        agencyVo = new AgencyVo();
                        agencyVo.setCompanyName((row.getCell(0).toString()));
                        agencyVo.setLeader(row.getCell(1).toString());
                        agencyVo.setEmailAcc(row.getCell(2).toString());
                        String type = row.getCell(3).toString();
                        agencyVo.setType(Integer.parseInt(type.substring(0,type.indexOf("."))));
                        infos.add(agencyVo);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return infos;
    }

}
