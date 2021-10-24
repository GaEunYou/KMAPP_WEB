package co.kesti.kmapp.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

@RestController
public class ImageController {
    @RequestMapping("/imgFind")
    public ArrayList<HashMap<String,String>> imgFind(@RequestParam String path) throws IOException {
        System.out.println(path);
        ArrayList<HashMap<String,String>> arrayList = new ArrayList<HashMap<String,String>>();
        HashMap<String, String> map = new HashMap<String, String>();

        //System.out.println(System.getProperty("user.dir"));
        //System.out.println(new File("").getAbsolutePath());
        //System.out.println(new File("").getCanonicalPath());

        File dir = new File(new File("").getAbsolutePath() + "/src/main/resources/static/" + path);
        File files[] = dir.listFiles();

        for (int i = 0; i < files.length; i++) {
            System.out.println("file: " + files[i].getName());
            map = new HashMap<String, String>();
            if(!("anal.log").equals(files[i].getName())){
                map.put("path",  "resources/" + path + "/"+ files[i].getName());
                arrayList.add(map);
            }
        }
        return arrayList;
    }
}
