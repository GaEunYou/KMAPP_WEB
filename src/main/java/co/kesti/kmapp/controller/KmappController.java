package co.kesti.kmapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;


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




    @RequestMapping(value = "/favicon.ico", method = RequestMethod.GET)
    public void favicon(HttpServletRequest request, HttpServletResponse reponse ) {
        try {
            reponse.sendRedirect("/resources/img/favicon.ico");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
