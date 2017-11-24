package com.fz.controller;

import com.fz.comment.Message;
import com.fz.comment.PathAutil;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;

@Controller
@RequestMapping("email")
public class EmailController {
    @RequestMapping("collection")
    public String collection(){
        return "collectionPage";
    }
    @RequestMapping("lookCollection")
    public String lookCollection(){
        return "lookCollectionPage";
    }
    @RequestMapping("writeCollection")
    public String writeCollection(){
        return "writeCollection";
    }
    @RequestMapping("upload")
    public Message upload(MultipartFile file, HttpServletRequest request) throws  Exception{
       try{
           String newname = getFileName(file.getOriginalFilename());
           FileUtils.copyInputStreamToFile(file.getInputStream(),new File(new PathAutil().getPath(request)+"/",newname));
           return Message.success("上传成功");
       }catch (Exception e){
           e.printStackTrace();
           return Message.success("上传失败");
       }
    }
    private synchronized String getFileName(String filename) {
        int position = filename.lastIndexOf(".");
        String ext = filename.substring(position);
        return System.nanoTime() + ext;
    }
}
