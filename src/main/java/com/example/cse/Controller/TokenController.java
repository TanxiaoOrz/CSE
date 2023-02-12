package com.example.cse.Controller;

import com.example.cse.Dto.UserDto;
import com.example.cse.Service.TokenService;
import com.example.cse.Service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/Token")
public class TokenController {
    @Autowired
    UserServiceImpl userService;
    @Autowired
    TokenService tokenService;

    private boolean checkEmpty(String name,String password){
        return StringUtils.hasText(name)&&StringUtils.hasText(password);
    }

    @PostMapping("/User")
    public Object login(@RequestParam String name,@RequestParam String password){
        if (checkEmpty(name,password)){
            UserDto userDto = userService.getUserByNamePass(name, password);
            String token = tokenService.newTokenByUser(userDto);
            return token;
        }else {
            return false;
        }
    }

}
