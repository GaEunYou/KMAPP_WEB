package co.kesti.kmapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class KmappController {
    @RequestMapping("/")
    public String index(){ return "index"; }

    @RequestMapping("/index")
    public String main(){ return "index"; }

    @RequestMapping("/kmapp")
    public String kmapp(){ return "kmapp"; }

    @RequestMapping("/dnsc")
    public String dnsc(){ return "dnsc"; }

}
