package com.fz.comment;

import javax.servlet.http.HttpServletRequest;
import java.io.File;

/**
 * Created by Administrator on 2017/9/8.
 */
public class PathAutil {

    public String getPath(HttpServletRequest request) throws  Exception{
        String filepath = request.getSession().getServletContext().getRealPath("/upfile");
        File file = new File(filepath);
        if (!file.exists()) {
            file.mkdir();
        }
        return file.getAbsolutePath();
    }
}
