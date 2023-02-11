package com.example.cse.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/Token")
public class TokenController {

    private boolean checkEmpty(String name,String password){
        return StringUtils.hasText(name)&&StringUtils.hasText(password);
    }

    @PostMapping("/User")
    public Object login(@RequestParam String name,@RequestParam String password){
        if (checkEmpty(name,password)){


            return true;
        }else {
            return false;
        }
    }

}
