package com.fz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/ueditor")
public class UeditorController {
    @RequestMapping("core")
    public String core() {
        return "ueditor/jsp/controller";
    }
}