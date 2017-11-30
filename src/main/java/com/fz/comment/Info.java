package com.fz.comment;

/**
 * Created by Administrator on 2017/9/8.
 */
public class Info {

    public static  final  String SUCCESS = "success";

    public static  final  String FAIL = "fail";

    private String result;

    private String message;

    public Info(){}

    public Info(String result , String message){
        this.result=result;
        this.message = message;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public static Info success(String message){

        return new Info(SUCCESS,message);
    }

    public static Info fail(String message){

        return new Info(SUCCESS,message);
    }
}
