package com.fz.controller;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
public class FileUpController {
    @RequestMapping("/uploadImage")
    @ResponseBody
    public Map<String,String> uploadImage(@RequestParam("upfile") CommonsMultipartFile upfile, HttpServletRequest request) throws IOException {
        System.out.println("+++++++++++++++++++++");
        String fileName=upfile.getOriginalFilename();
        String type = fileName.substring(upfile.getOriginalFilename().lastIndexOf("."));
        String nowName=getFileName(fileName)+ type;
        if(!upfile.isEmpty()){
            String path0 = "D:\\static\\ueditor\\jsp\\upload\\image\\"+nowName;
            File newFile = new File(path0);
            FileCopyUtils.copy(upfile.getBytes(), newFile);
        }

        Map<String,String> map = new HashMap<String,String >();
        map.put("state", "SUCCESS");
        map.put("title", nowName);
        map.put("original", fileName);
        map.put("type", type);
        map.put("url", "/webCol/"+nowName+"/getImage");
        map.put("size", upfile.getSize()+"");
        return map;

    }

    /**
     * ueditor读取文件重写
     */
    @RequestMapping("{imgName}/getImage")
    public void readImg(@PathVariable("imgName") String imgName, HttpServletResponse response)  throws Exception {
        //设置文件的返回类型
        response.setContentType("image/*");
        //文件路径(windows下是\\，linux下是//，都必须是绝对路径)
        String imgPath="D:\\static\\ueditor\\jsp\\upload\\image\\"+imgName;
        //java中用File类来表示一个文件
        File image = new File(imgPath);
        //测试这个文件路径是否存在（也就是这个文件是否存在）
        if (!image.exists()) {
            return;
        }
        //FileUtils.readFileToByteArray(File file)把一个文件转换成字节数组返回
        response.getOutputStream().write(FileUtils.readFileToByteArray(image));
        //java在使用流时,都会有一个缓冲区,按一种它认为比较高效的方法来发数据:
        //把要发的数据先放到缓冲区,缓冲区放满以后再一次性发过去,而不是分开一次一次地发.
        //而flush()表示强制将缓冲区中的数据发送出去,不必等到缓冲区满.
        response.getOutputStream().flush();
        response.getOutputStream().close();
    }
    private synchronized String getFileName(String filename) {
        int position = filename.lastIndexOf(".");
        String ext = filename.substring(position);
        return System.nanoTime() + ext;
    }
}
